import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/settings.dart';

final Logger log = Logger("Pages.Categories.AddEdit");

class CategoryAddEditDialog extends StatefulWidget {
  const CategoryAddEditDialog({super.key, this.category});

  final CategoryRead? category;

  @override
  State<CategoryAddEditDialog> createState() => _CategoryAddEditDialogState();
}

class _CategoryAddEditDialogState extends State<CategoryAddEditDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  bool loaded = false;
  bool includeInSum = true;

  @override
  void initState() {
    super.initState();

    if (widget.category == null) {
      // no setstate needed, the only if below checks for category null as well
      loaded = true;
      return;
    }

    titleController.text = widget.category!.attributes.name;

    context
        .read<FireflyService>()
        .api
        .v1CategoriesIdGet(id: widget.category!.id)
        .then((Response<CategorySingle> resp) {
          if (!resp.isSuccessful || resp.body == null) {
            log.severe("Error fetching information", resp.error);
            if (mounted) {
              Navigator.of(context).pop();
            }
          }
          setState(() {
            includeInSum =
                !context
                    .read<SettingsProvider>()
                    .categoriesSumExcluded
                    .contains(widget.category!.id);
            notesController.text = resp.body?.data.attributes.notes ?? "";
            loaded = true;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    //final Logger log = Logger("Pages.Categories.AddEditDialog");
    final double inputWidth = MediaQuery.of(context).size.width - 128 - 24;

    return AlertDialog.adaptive(
      icon: const Icon(Icons.assignment),
      title: Text(
        widget.category == null
            ? S.of(context).categoryTitleAdd
            : S.of(context).categoryTitleEdit,
      ),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        if (widget.category != null)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.errorContainer,
              ),
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
            onPressed: () async {
              final FireflyIii api = context.read<FireflyService>().api;

              final bool? ok = await showDialog(
                context: context,
                builder:
                    (BuildContext context) => const DeletionConfirmDialog(),
              );
              if (!(ok ?? false)) {
                return;
              }

              await api.v1CategoriesIdDelete(id: widget.category!.id);

              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            },
          ),
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FilledButton(
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          onPressed: () async {
            final ScaffoldMessengerState msg = ScaffoldMessenger.of(context);

            late Response<CategorySingle> resp;
            if (widget.category == null) {
              resp = await context.read<FireflyService>().api.v1CategoriesPost(
                body: CategoryStore(
                  name: titleController.text,
                  notes: notesController.text,
                ),
              );
            } else {
              resp = await context.read<FireflyService>().api.v1CategoriesIdPut(
                id: widget.category!.id,
                body: CategoryUpdate(
                  name: titleController.text,
                  notes: notesController.text,
                ),
              );
            }

            // Check if insert/update was successful
            if (!resp.isSuccessful || resp.body == null) {
              late String error;
              try {
                final ValidationErrorResponse valError =
                    ValidationErrorResponse.fromJson(
                      json.decode(resp.error.toString()),
                    );
                error =
                    valError.message ??
                    (context.mounted
                        ? S.of(context).errorUnknown
                        : "[nocontext] Unknown error.");
              } catch (_) {
                error =
                    context.mounted
                        ? S.of(context).errorUnknown
                        : "[nocontext] Unknown error.";
              }

              msg.showSnackBar(
                SnackBar(
                  content: Text(error),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            if (context.mounted) {
              if (includeInSum) {
                await context
                    .read<SettingsProvider>()
                    .categoryRemoveSumExcluded(widget.category!.id);
              } else {
                await context.read<SettingsProvider>().categoryAddSumExcluded(
                  widget.category!.id,
                );
              }
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: inputWidth,
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.title),
                  border: const OutlineInputBorder(),
                  labelText: S.of(context).categoryFormLabelName,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: inputWidth,
              child: TextFormField(
                controller: notesController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.description),
                  border: const OutlineInputBorder(),
                  labelText: S.of(context).transactionFormLabelNotes,
                ),
                enabled: loaded == true || widget.category == null,
                minLines: 1,
                maxLines: 5,
              ),
            ),
            // Only show toggle (+ spacing) when in edit mode
            if (widget.category != null) const SizedBox(height: 12),
            if (widget.category != null)
              SizedBox(
                width: inputWidth,
                child: SwitchListTile.adaptive(
                  title: Text(S.of(context).categoryFormLabelIncludeInSum),
                  value: includeInSum,
                  isThreeLine: false,
                  onChanged:
                      loaded != true
                          ? null
                          : (bool value) => setState(() {
                            includeInSum = value;
                          }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DeletionConfirmDialog extends StatelessWidget {
  const DeletionConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const Icon(Icons.delete),
      title: Text(S.of(context).categoryTitleDelete),
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
      content: Text(S.of(context).categoryDeleteConfirm),
    );
  }
}
