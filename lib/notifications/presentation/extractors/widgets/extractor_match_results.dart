import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_expandable_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

class ExtractorMatchResults extends StatefulWidget {
  const ExtractorMatchResults({super.key, required this.evaluation});

  final RegExpEvaluationResult evaluation;

  @override
  State<ExtractorMatchResults> createState() => _ExtractorMatchResultsState();
}

class _ExtractorMatchResultsState extends State<ExtractorMatchResults> {
  final Set<int> _expandedMatchIndexes = <int>{};

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(height: 24),
      Row(
        children: <Widget>[
          const Icon(Icons.manage_search_outlined),
          const SizedBox(width: 8),
          Text(
            S.of(context).notificationsExtractorMatches,
            style: context.notificationSectionTitle,
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        S.of(context).notificationsExtractorPatternMatchesDescription,
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 12),
      if (!widget.evaluation.hasMatches)
        MessageStatusCard(
          status: MessageStatus.warning,
          title: S.of(context).notificationsExtractorNoSampleMatch,
          message: S.of(context).notificationsExtractorNoSampleMatchMessage,
        )
      else
        ..._matchCards(),
    ],
  );

  List<Widget> _matchCards() =>
      widget.evaluation.matches.indexed.map(((int, RegExpMatch) entry) {
        final int index = entry.$1;
        final List<_MatchValue> values = _valuesForMatch(entry.$2);
        final bool expanded = _expandedMatchIndexes.contains(index);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DefinitionExpandableDetailCard(
            expanded: expanded,
            onTap: () => setState(() {
              expanded
                  ? _expandedMatchIndexes.remove(index)
                  : _expandedMatchIndexes.add(index);
            }),
            leading: const Icon(Icons.filter_1_outlined),
            title: Text(
              S.of(context).notificationsExtractorMatchNumber(index + 1),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              entry.$2.group(0) ?? '',
              style: context.notificationSupportingText,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                child: const Icon(Icons.expand_more),
              ),
            ),
            headerKey: Key('extractor-match-$index'),
            bellyKey: Key('extractor-match-belly-$index'),
            bellyColor: Theme.of(context).scaffoldBackgroundColor,
            bellyBorder: Border.all(color: _cardBackground, width: 2),
            bellyPadding: const EdgeInsets.all(8),
            belly: Column(
              children: values.indexed
                  .map(
                    ((int, _MatchValue) value) => Padding(
                      padding: EdgeInsets.only(
                        bottom: value.$1 == values.length - 1 ? 0 : 8,
                      ),
                      child: _valueCard(value.$2),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }).toList();

  List<_MatchValue> _valuesForMatch(RegExpMatch match) {
    final List<_MatchValue> values = match.groupNames
        .where((String name) => (match.namedGroup(name) ?? '').isNotEmpty)
        .map(
          (String name) => _MatchValue(
            name,
            match.namedGroup(name)!,
            _inferType(match.namedGroup(name)!),
          ),
        )
        .toList();
    return values.isEmpty
        ? <_MatchValue>[
            _MatchValue(
              S.of(context).notificationsExtractorMatch,
              match.group(0) ?? '',
              _inferType(match.group(0) ?? ''),
            ),
          ]
        : values;
  }

  String _inferType(String value) {
    if (RegExp(r'^[-+]?\d+(?:[.,]\d+)?$').hasMatch(value.trim())) {
      return S.of(context).notificationsValueTypeNumber;
    }
    if (RegExp(r'^[A-Z]{3}$').hasMatch(value.trim())) {
      return S.of(context).notificationsValueTypeCurrency;
    }
    if (DateTime.tryParse(value.trim()) != null) {
      return S.of(context).notificationsValueTypeDateTime;
    }
    return S.of(context).notificationsValueTypeText;
  }

  Widget _valueCard(_MatchValue value) => DefinitionDetailCard(
    leading: const Icon(Icons.text_fields_outlined),
    title: Text(value.label),
    subtitle: _valueSubtitle(value),
    trailing: Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(value.type, style: context.notificationValueTypeText),
    ),
    backgroundColor: _cardBackground,
  );

  Widget _valueSubtitle(_MatchValue value) {
    final DateTime? dateTime = DateTime.tryParse(value.value.trim());
    if (dateTime == null) {
      return Text(value.value, style: context.notificationSupportingText);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(value.value, style: context.notificationSupportingText),
        const SizedBox(height: 2),
        Text(
          '${S.of(context).notificationsLocalizedValueLabel}'
          '${formatNotificationDateTime(context, dateTime)}',
          style: context.notificationSupportingText,
        ),
      ],
    );
  }

  Color get _cardBackground =>
      Theme.of(context).cardTheme.color ??
      Theme.of(context).colorScheme.surfaceContainerLow;
}

class _MatchValue {
  const _MatchValue(this.label, this.value, this.type);

  final String label;
  final String value;
  final String type;
}
