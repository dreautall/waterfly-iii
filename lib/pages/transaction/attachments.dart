import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;
import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:open_filex/open_filex.dart';

import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

class AttachmentDialog extends StatefulWidget {
  const AttachmentDialog({
    super.key,
    required this.attachments,
    required this.transactionId,
  });

  final List<AttachmentRead> attachments;
  final String? transactionId;

  @override
  State<AttachmentDialog> createState() => _AttachmentDialogState();
}

class _AttachmentDialogState extends State<AttachmentDialog>
    with SingleTickerProviderStateMixin {
  final Logger log = Logger("Pages.Transaction.AttachmentDialog");

  final Map<int, double> _dlProgress = <int, double>{};

  void downloadAttachment(
    BuildContext context,
    AttachmentRead attachment,
    int i,
  ) async {
    final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
    final AuthUser? user = context.read<FireflyService>().user;
    final S l10n = S.of(context);
    late int total;
    int received = 0;
    final List<int> fileData = <int>[];

    if (user == null) {
      throw Exception(l10n.errorAPIUnavailable);
    }

    final Directory tmpPath = await getTemporaryDirectory();
    final String filePath = "${tmpPath.path}/${attachment.attributes.filename}";

    final HttpClientRequest request = await HttpClient().getUrl(
      Uri.parse(attachment.attributes.downloadUrl!),
    );
    user.headers().forEach(
          (String key, String value) => request.headers.add(key, value),
        );
    final HttpClientResponse resp = await request.close();
    if (resp.statusCode != 200) {
      log.warning("got invalid status code ${resp.statusCode}");
      msg.showSnackBar(SnackBar(
        content: Text(l10n.transactionDialogAttachmentsErrorDownload),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    total = resp.headers.contentLength;
    if (total == 0) {
      total = attachment.attributes.size ?? 0;
    }
    resp.listen(
      (List<int> value) {
        setState(() {
          fileData.addAll(value);
          received += value.length;
          _dlProgress[i] = received / total;
          log.finest(
            () =>
                "received ${value.length} bytes (total $received of $total), ${received / total * 100}%",
          );
        });
      },
      cancelOnError: true,
      onDone: () async {
        setState(() {
          _dlProgress.remove(i);
        });
        log.finest(() => "writing ${fileData.length} bytes to $filePath");
        await File(filePath).writeAsBytes(fileData, flush: true);
        final OpenResult file = await OpenFilex.open(filePath);
        if (file.type != ResultType.done) {
          log.severe("error opening file", file.message);
          msg.showSnackBar(SnackBar(
            content:
                Text(l10n.transactionDialogAttachmentsErrorOpen(file.message)),
            behavior: SnackBarBehavior.floating,
          ));
        }
      },
      onError: (Error e) {
        log.severe("download error", e);
        setState(() {
          _dlProgress.remove(i);
        });
        msg.showSnackBar(SnackBar(
          content: Text(l10n.transactionDialogAttachmentsErrorDownload),
          behavior: SnackBarBehavior.floating,
        ));
      },
    );
  }

  void deleteAttachment(
    BuildContext context,
    AttachmentRead attachment,
    int i,
  ) async {
    final FireflyIii api = context.read<FireflyService>().api;
    bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
          const AttachmentDeletionConfirmDialog(),
    );
    if (ok == null || !ok) {
      return;
    }

    await api.v1AttachmentsIdDelete(id: attachment.id);
    setState(() {
      widget.attachments.removeAt(i);
    });
  }

  void uploadAttachment(BuildContext context, PlatformFile file) async {
    final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
    final FireflyIii api = context.read<FireflyService>().api;
    final AuthUser? user = context.read<FireflyService>().user;
    final S l10n = S.of(context);

    if (user == null) {
      throw Exception(l10n.errorAPIUnavailable);
    }

    final Response<AttachmentSingle> respAttachment =
        await api.v1AttachmentsPost(
      body: AttachmentStore(
        filename: file.name,
        attachableType: AttachableType.transactionjournal,
        attachableId: widget.transactionId!,
      ),
    );
    if (!respAttachment.isSuccessful || respAttachment.body == null) {
      late String error;
      try {
        ValidationErrorResponse valError = ValidationErrorResponse.fromJson(
            json.decode(respAttachment.error.toString()));
        error = valError.message ?? l10n.errorUnknown;
      } catch (_) {
        error = l10n.errorUnknown;
      }
      msg.showSnackBar(SnackBar(
        content: Text(l10n.transactionDialogAttachmentsErrorUpload(error)),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    final AttachmentRead newAttachment = respAttachment.body!.data;
    int newAttachmentIndex =
        widget.attachments.length; // Will be added later, no -1 needed.
    final int total = file.size;
    int sent = 0;

    setState(() {
      widget.attachments.add(newAttachment);
      _dlProgress[newAttachmentIndex] = -0.0001;
    });

    final HttpClientRequest request = await HttpClient().postUrl(
      Uri.parse(newAttachment.attributes.uploadUrl!),
    );
    user.headers().forEach(
          (String key, String value) => request.headers.add(key, value),
        );
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/octet-stream");
    log.fine(() => "AttachmentUpload: Starting Upload $newAttachmentIndex");

    final Stream<List<int>> listenStream =
        File(file.path!).openRead().transform(
              StreamTransformer<List<int>, List<int>>.fromHandlers(
                handleData: (List<int> data, EventSink<List<int>> sink) {
                  setState(() {
                    sent += data.length;
                    _dlProgress[newAttachmentIndex] = sent / total * -1;
                    log.finest(
                      () =>
                          "sent ${data.length} bytes (total $sent of $total), ${sent / total * 100}%",
                    );
                  });
                  sink.add(data);
                },
                handleDone: (EventSink<List<int>> sink) {
                  sink.close();
                },
              ),
            );

    await request.addStream(listenStream);
    final HttpClientResponse resp = await request.close();
    log.fine(() => "AttachmentUpload: Done with Upload $newAttachmentIndex");
    setState(() {
      _dlProgress.remove(newAttachmentIndex);
    });
    if (resp.statusCode == HttpStatus.ok ||
        resp.statusCode == HttpStatus.created ||
        resp.statusCode == HttpStatus.noContent) {
      return;
    }
    late String error;
    try {
      final String respString = await resp.transform(utf8.decoder).join();
      ValidationErrorResponse valError =
          ValidationErrorResponse.fromJson(json.decode(respString));
      error = valError.message ?? l10n.errorUnknown;
    } catch (_) {
      error = l10n.errorUnknown;
    }
    msg.showSnackBar(SnackBar(
      content: Text(l10n.transactionDialogAttachmentsErrorUpload(error)),
      behavior: SnackBarBehavior.floating,
    ));
    await api.v1AttachmentsIdDelete(id: newAttachment.id);
    setState(() {
      widget.attachments.removeAt(newAttachmentIndex);
    });
  }

  void fakeDownloadAttachment(
    BuildContext context,
    AttachmentRead attachment,
  ) async {
    final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);
    final S l10n = S.of(context);

    final OpenResult file =
        await OpenFilex.open(attachment.attributes.uploadUrl);
    if (file.type != ResultType.done) {
      log.severe("error opening file", file.message);
      msg.showSnackBar(SnackBar(
        content: Text(l10n.transactionDialogAttachmentsErrorOpen(file.message)),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void fakeDeleteAttachment(
    BuildContext context,
    int i,
  ) async {
    bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
          const AttachmentDeletionConfirmDialog(),
    );
    if (ok == null || !ok) {
      return;
    }
    setState(() {
      widget.attachments.removeAt(i);
    });
  }

  void fakeUploadAttachment(BuildContext context, PlatformFile file) async {
    final AttachmentRead newAttachment = AttachmentRead(
      type: "attachments",
      id: widget.attachments.length.toString(),
      attributes: Attachment(
        attachableType: AttachableType.transactionjournal,
        attachableId: "FAKE",
        filename: file.name,
        uploadUrl: file.path,
        size: file.size,
      ),
      links: const ObjectLink(),
    );
    setState(() {
      widget.attachments.add(newAttachment);
    });
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build(transactionId: ${widget.transactionId})");
    List<Widget> childs = <Widget>[];
    for (int i = 0; i < widget.attachments.length; i++) {
      AttachmentRead attachment = widget.attachments[i];
      String subtitle = "";
      DateTime? modDate =
          attachment.attributes.updatedAt ?? attachment.attributes.createdAt;
      if (modDate != null) {
        subtitle = DateFormat.yMd().add_Hms().format(modDate.toLocal());
      }

      if (attachment.attributes.size != null) {
        subtitle = "$subtitle (${filesize(attachment.attributes.size)})";
      }
      childs.add(ListTile(
        enabled: (_dlProgress[i] != null && _dlProgress[i]! < 0) ? false : true,
        leading: MaterialIconButton(
          icon: (_dlProgress[i] != null && _dlProgress[i]! < 0)
              ? Icons.upload
              : Icons.download,
          onPressed: _dlProgress[i] != null
              ? null
              : widget.transactionId == null
                  ? () async => fakeDownloadAttachment(context, attachment)
                  : () async => downloadAttachment(context, attachment, i),
        ),
        title: Text(
          attachment.attributes.title ?? attachment.attributes.filename,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: false,
        trailing: MaterialIconButton(
          icon: Icons.delete,
          onPressed: (_dlProgress[i] != null && _dlProgress[i]! < 0)
              ? null
              : widget.transactionId == null
                  ? () async => fakeDeleteAttachment(context, i)
                  : () async => deleteAttachment(context, attachment, i),
        ),
      ));
      final DividerThemeData divTheme = DividerTheme.of(context);
      childs.add(
        SizedBox(
          height: divTheme.space ?? 16,
          child: Center(
            child: _dlProgress[i] == null
                ? const Divider(height: 0)
                : LinearProgressIndicator(
                    value: _dlProgress[i]!.abs(),
                    //minHeight: divTheme.thickness ?? 4,
                    //backgroundColor: divTheme.color ?? theme.colorScheme.outlineVariant,
                  ),
          ),
        ),
      );
    }
    childs.add(
      OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 12,
        overflowSpacing: 12,
        children: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          ),
          FilledButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? imageFile =
                  await picker.pickImage(source: ImageSource.camera);

              if (imageFile == null) {
                log.finest(() => "no image returned");
                return;
              }

              log.finer(() => "Image ${imageFile.path} will be uploaded");
              final PlatformFile file = PlatformFile(
                path: imageFile.path,
                name: imageFile.name,
                size: await imageFile.length(),
              );
              if (context.mounted) {
                if (widget.transactionId == null) {
                  fakeUploadAttachment(context, file);
                } else {
                  uploadAttachment(context, file);
                }
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
          FilledButton(
            onPressed: () async {
              FilePickerResult? file = await FilePicker.platform.pickFiles();
              if (file == null || file.files.first.path == null) {
                return;
              }
              if (context.mounted) {
                if (widget.transactionId == null) {
                  fakeUploadAttachment(context, file.files.first);
                } else {
                  uploadAttachment(context, file.files.first);
                }
              }
            },
            child: const Icon(Icons.upload_file),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
    return SimpleDialog(
      title: Text(S.of(context).transactionDialogAttachmentsTitle),
      clipBehavior: Clip.hardEdge,
      children: childs,
    );
  }
}

class AttachmentDeletionConfirmDialog extends StatelessWidget {
  const AttachmentDeletionConfirmDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete),
      title: Text(S.of(context).transactionDialogAttachmentsDelete),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          child: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Text(S.of(context).transactionDialogAttachmentsDeleteConfirm),
    );
  }
}
