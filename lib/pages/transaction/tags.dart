import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:chopper/chopper.dart' show Response;

import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/auth.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class Tags {
  final List<String>? initialTags;
  Tags([this.initialTags]) {
    _tags = initialTags ?? <String>[];
  }

  late List<String> _tags;

  List<String> get tags => _tags;

  void add(String tag) {
    if (!_tags.containsIgnoreCase(tag)) {
      _tags.add(tag);
    }
  }

  void remove(String tag) {
    if (_tags.containsIgnoreCase(tag)) {
      _tags.remove(tag);
    }
  }

  void replace(List<String> tags) {
    _tags = tags;
  }
}

class TransactionTags extends StatefulWidget {
  const TransactionTags({
    super.key,
    required this.textController,
    required this.tagsController,
    this.enableAdd = true,
  });

  final TextEditingController textController;
  final Tags tagsController;
  final bool enableAdd;

  @override
  State<TransactionTags> createState() => _TransactionTagsState();
}

class _TransactionTagsState extends State<TransactionTags> {
  final Logger log = Logger("Pages.Transaction.Tags");

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build()");
    FocusNode disabledFocus = AlwaysDisabledFocusNode();
    return Row(
      children: <Widget>[
        Expanded(
          child: AnimatedHeight(
            child: TextFormField(
              controller: widget.textController,
              maxLines: null,
              readOnly: true,
              focusNode: disabledFocus,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: S.of(context).transactionFormLabelTags,
                icon: const Icon(Icons.bookmarks),
                prefixIcon: widget.tagsController.tags.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: widget.tagsController.tags
                              .map(
                                (String e) => InputChip(
                                  label: Text(e),
                                  onDeleted: () {
                                    setState(() {
                                      widget.tagsController.remove(e);
                                      widget.textController.text = (widget
                                              .tagsController.tags.isNotEmpty)
                                          ? " "
                                          : "";
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : null,
              ),
              onTap: () async {
                List<String>? tags = await showDialog<List<String>>(
                  context: context,
                  builder: (BuildContext context) => TagDialog(
                    selectedTags: widget.tagsController.tags,
                    enableAdd: widget.enableAdd,
                  ),
                );
                // Cancelled
                if (tags == null) {
                  return;
                }
                setState(() {
                  widget.tagsController.replace(tags);
                  widget.textController.text =
                      (widget.tagsController.tags.isNotEmpty) ? " " : "";
                });
              },
            ),
          ),
        )
      ],
    );
  }
}

class TagDialog extends StatefulWidget {
  const TagDialog({
    super.key,
    required this.selectedTags,
    required this.enableAdd,
  });

  final List<String> selectedTags;
  final bool enableAdd;

  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  final TextEditingController _newTagTextController = TextEditingController();

  late List<String> _newSelectedTags;

  @override
  void initState() {
    super.initState();

    _newSelectedTags = widget.selectedTags.toList();
  }

  @override
  void dispose() {
    _newTagTextController.dispose();

    super.dispose();
  }

  Future<List<String>>? _getTags() async {
    final FireflyIii api = context.read<FireflyService>().api;
    List<String> tags = <String>[];
    late Response<TagArray> response;
    int pageNumber = 0;

    do {
      pageNumber += 1;
      response = await api.v1TagsGet(page: pageNumber);

      if (!response.isSuccessful || response.body == null) {
        if (context.mounted) {
          throw Exception(
            S
                .of(context)
                .errorAPIInvalidResponse(response.error?.toString() ?? ""),
          );
        } else {
          throw Exception(
            "[nocontext] Invalid API response: ${response.error}",
          );
        }
      }

      tags.addAll(response.body!.data.map((TagRead e) => e.attributes.tag));
    } while ((response.body!.meta.pagination?.currentPage ?? 1) <
        (response.body!.meta.pagination?.totalPages ?? 1));

    return tags;
  }

  void _newTagSubmitted(
    StateSetter setState,
    List<String> allTags,
    String value,
  ) {
    if (!widget.enableAdd) {
      return;
    }
    if (value.isEmpty) {
      return;
    }
    _newTagTextController.clear();
    if (_newSelectedTags.containsIgnoreCase(value)) {
      setState(() {});
      return;
    }
    if (allTags.containsIgnoreCase(value)) {
      setState(() {
        _newSelectedTags.add(value);
      });
      return;
    }
    setState(() {
      allTags.add(value);
      _newSelectedTags.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).transactionDialogTagsTitle),
      clipBehavior: Clip.hardEdge,
      actions: <Widget>[
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FilledButton(
          child: Text(MaterialLocalizations.of(context).saveButtonLabel),
          onPressed: () {
            Navigator.pop(context, _newSelectedTags);
          },
        )
      ],
      content: FutureBuilder<List<String>>(
        future: _getTags(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            List<String> allTags =
                <String>{...snapshot.data!, ..._newSelectedTags}.toList();
            bool showAddTag = true;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setAlertState) {
                showAddTag = _newTagTextController.text.isNotEmpty &&
                    !_newSelectedTags
                        .containsIgnoreCase(_newTagTextController.text);
                allTags.sort((String a, String b) {
                  if (_newSelectedTags.containsIgnoreCase(a) &&
                      !_newSelectedTags.containsIgnoreCase(b)) {
                    return -1;
                  } else if (!_newSelectedTags.containsIgnoreCase(a) &&
                      _newSelectedTags.containsIgnoreCase(b)) {
                    return 1;
                  } else {
                    return a.toLowerCase().compareTo(b.toLowerCase());
                  }
                });
                List<Widget> child = <Widget>[
                  TextField(
                    controller: _newTagTextController,
                    onChanged: (String value) {
                      setAlertState(() {});
                    },
                    onSubmitted: (String value) => widget.enableAdd
                        ? _newTagSubmitted(setAlertState, allTags, value)
                        : null,
                    decoration: InputDecoration(
                        hintText: widget.enableAdd
                            ? S.of(context).transactionDialogTagsHint
                            : S.of(context).transactionDialogTagsTitle,
                        icon: const Icon(Icons.bookmark_add),
                        suffixIcon: (showAddTag && widget.enableAdd)
                            ? Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => _newTagSubmitted(
                                    setAlertState,
                                    allTags,
                                    _newTagTextController.text,
                                  ),
                                  tooltip:
                                      S.of(context).transactionDialogTagsAdd,
                                ),
                              )
                            : null),
                  ),
                  const Divider(),
                ];
                final Iterable<String> filteredTags = allTags.where(
                    (String t) =>
                        _newTagTextController.text.isEmpty ||
                        (_newTagTextController.text.isNotEmpty &&
                            t.containsIgnoreCase(_newTagTextController.text)));
                for (String tag in filteredTags) {
                  if (_newTagTextController.text.isNotEmpty &&
                      !tag.containsIgnoreCase(_newTagTextController.text)) {
                    continue;
                  }
                  child.add(CheckboxListTile(
                    value: _newSelectedTags.containsIgnoreCase(tag),
                    onChanged: (bool? selected) {
                      setAlertState(
                        () {
                          if ((selected == null || !selected) &&
                              _newSelectedTags.containsIgnoreCase(tag)) {
                            _newSelectedTags.remove(tag);
                          } else if ((selected != null && selected) &&
                              !_newSelectedTags.containsIgnoreCase(tag)) {
                            _newSelectedTags.add(tag);
                            if (filteredTags
                                .where((String t) =>
                                    !_newSelectedTags.containsIgnoreCase(t))
                                .isEmpty) {
                              _newTagTextController.text = "";
                            }
                          }
                        },
                      );
                    },
                    title: Text(tag),
                  ));
                  child.add(const Divider());
                }

                return SingleChildScrollView(
                  child: AnimatedHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: child,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            log.severe(
                "error getting tags", snapshot.error, snapshot.stackTrace);
            Navigator.pop(context);
            return const CircularProgressIndicator();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
