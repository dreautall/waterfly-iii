import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';

typedef TransactionTagLoader = Future<List<String>> Function();

class TransactionActionTagsStep extends StatefulWidget {
  const TransactionActionTagsStep({
    super.key,
    required this.selectedTags,
    required this.loadTags,
    required this.onChanged,
  });

  final List<String> selectedTags;
  final TransactionTagLoader loadTags;
  final ValueChanged<List<String>> onChanged;

  @override
  State<TransactionActionTagsStep> createState() =>
      _TransactionActionTagsStepState();
}

class _TransactionActionTagsStepState extends State<TransactionActionTagsStep> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _addedTags = <String>[];
  late Future<List<String>> _tags;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _load() {
    _tags = widget.loadTags();
  }

  void _retry() {
    setState(_load);
  }

  void _toggle(
    String tag,
    bool selected, [
    Iterable<String> filteredTags = const <String>[],
  ]) {
    final List<String> next = List<String>.of(widget.selectedTags);
    final int index = next.indexWhere(
      (String item) => item.toLowerCase() == tag.toLowerCase(),
    );
    if (selected && index == -1) {
      next.add(tag);
    } else if (!selected && index != -1) {
      next.removeAt(index);
    }
    widget.onChanged(next);
    if (selected &&
        _searchController.text.isNotEmpty &&
        filteredTags.every(next.containsIgnoreCase)) {
      _searchController.clear();
    }
  }

  void _submitTag() {
    final String tag = _searchController.text.trim();
    if (tag.isEmpty) return;
    if (!_addedTags.containsIgnoreCase(tag)) _addedTags.add(tag);
    _toggle(tag, true);
    _searchController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _tags,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Column(
            key: const Key('action-tags-load-error'),
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NotificationInlineEmptyState(
                message: S.of(context).notificationsActionTagsLoadFailure,
                status: NotificationInlineEmptyStateStatus.error,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: Text(S.of(context).notificationsHealthRetry),
              ),
            ],
          );
        }

        final List<String> allTags = <String>[];
        for (final String tag in <String>[
          ...?snapshot.data,
          ..._addedTags,
          ...widget.selectedTags,
        ]) {
          if (!allTags.containsIgnoreCase(tag)) allTags.add(tag);
        }
        allTags.sort((String a, String b) {
          final bool aSelected = widget.selectedTags.containsIgnoreCase(a);
          final bool bSelected = widget.selectedTags.containsIgnoreCase(b);
          if (aSelected != bSelected) return aSelected ? -1 : 1;
          return a.toLowerCase().compareTo(b.toLowerCase());
        });

        final String query = _searchController.text.trim();
        final List<String> filteredTags = allTags
            .where(
              (String tag) =>
                  query.isEmpty ||
                  tag.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        final bool canAdd =
            query.isNotEmpty && !widget.selectedTags.containsIgnoreCase(query);

        return Column(
          key: const Key('action-tags-step'),
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              key: const Key('action-tags-search'),
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _submitTag(),
              decoration: notificationInputDecoration(
                context,
                labelText: S.of(context).transactionDialogTagsHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: canAdd
                    ? IconButton(
                        key: const Key('action-tags-add'),
                        onPressed: _submitTag,
                        tooltip: S.of(context).transactionDialogTagsAdd,
                        icon: const Icon(Icons.add),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              fit: FlexFit.loose,
              child: ListView(
                key: const Key('action-tags-list'),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: filteredTags
                    .map(
                      (String tag) => CheckboxListTile.adaptive(
                        key: ValueKey<String>('action-tag-$tag'),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: widget.selectedTags.containsIgnoreCase(tag),
                        onChanged: (bool? selected) =>
                            _toggle(tag, selected ?? false, filteredTags),
                        title: Text(tag),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
