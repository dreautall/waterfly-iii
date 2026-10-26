import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_capture_option_list.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

class ExtractorCaptureSelection {
  const ExtractorCaptureSelection({
    required this.extractor,
    required this.captureName,
    required this.matchIndex,
    required this.value,
    this.fallbackCaptureIndex,
  });

  final RegExpDefinition extractor;
  final String captureName;
  final int matchIndex;
  final String value;
  final int? fallbackCaptureIndex;

  RegExpCaptureValueSource toValueSource() => RegExpCaptureValueSource(
    extractorId: extractor.id,
    captureName: captureName,
    fallbackCaptureIndex: fallbackCaptureIndex,
    matchIndex: matchIndex,
  );
}

typedef CaptureAllowed =
    bool Function(RegExpDefinition extractor, String captureName, String value);

class ExtractorCapturePicker extends StatefulWidget {
  const ExtractorCapturePicker({
    super.key,
    required this.extractors,
    required this.notificationContext,
    required this.onSelected,
    this.isCaptureAllowed,
    this.emptyMessage,
  });

  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final ValueChanged<ExtractorCaptureSelection> onSelected;
  final CaptureAllowed? isCaptureAllowed;
  final String? emptyMessage;

  static bool hasAvailableCapture({
    required List<RegExpDefinition> extractors,
    required NotificationContext notificationContext,
    CaptureAllowed? isCaptureAllowed,
  }) => extractors.any(
    (RegExpDefinition extractor) => extractor
        .evaluate(notificationContext)
        .matches
        .any(
          (RegExpMatch match) =>
              _hasAvailableCapture(extractor, match, isCaptureAllowed),
        ),
  );

  static bool _hasAvailableCapture(
    RegExpDefinition extractor,
    RegExpMatch match,
    CaptureAllowed? isCaptureAllowed,
  ) {
    bool isAllowed(String captureName, String? value) =>
        value != null &&
        value.isNotEmpty &&
        (isCaptureAllowed?.call(extractor, captureName, value) ?? true);

    if (match.groupNames.any(
      (String name) => isAllowed(name, match.namedGroup(name)),
    )) {
      return true;
    }
    return Iterable<int>.generate(
      match.groupCount,
      (int index) => index + 1,
    ).any((int index) => isAllowed('#$index', match.group(index)));
  }

  @override
  State<ExtractorCapturePicker> createState() => _ExtractorCapturePickerState();
}

class _ExtractorCapturePickerState extends State<ExtractorCapturePicker> {
  RegExpDefinition? _extractor;
  int? _matchIndex;
  bool _movingForward = true;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) =>
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[...previousChildren, ?currentChild],
            ),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            AnimatedBuilder(
              animation: animation,
              child: child,
              builder: (BuildContext context, Widget? child) {
                final bool entering =
                    animation.status != AnimationStatus.reverse;
                final double distance = (1 - animation.value) * 440;
                return Transform.translate(
                  offset: Offset(
                    (entering == _movingForward ? 1 : -1) * distance,
                    0,
                  ),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            ),
        child: _choiceLevel(),
      ),
    ),
  );

  Widget _choiceLevel() {
    final RegExpDefinition? extractor = _extractor;
    if (extractor == null) return _extractorChoices();
    final List<(int, RegExpMatch)> matches = _matchesFor(extractor);
    if (matches.length > 1 && _matchIndex == null) {
      return _matchChoices(extractor, matches);
    }
    final int matchIndex = _matchIndex ?? matches.single.$1;
    final RegExpMatch match = matches
        .firstWhere(((int, RegExpMatch) entry) => entry.$1 == matchIndex)
        .$2;
    return _groupChoices(extractor, match, matchIndex);
  }

  Widget _extractorChoices() {
    final List<RegExpDefinition> extractors = widget.extractors
        .where(
          (RegExpDefinition extractor) => _matchesFor(extractor).isNotEmpty,
        )
        .toList();
    return ExtractorCaptureOptionList(
      listKey: const ValueKey<String>('capture-extractors'),
      emptyMessage:
          widget.emptyMessage ?? S.of(context).notificationsCaptureEmpty,
      options: extractors.map((RegExpDefinition extractor) {
        final List<(int, RegExpMatch)> matches = _matchesFor(extractor);
        final List<_Capture> captures = _capturesFor(
          extractor,
          matches.first.$2,
        );
        final bool selectDirectly = matches.length == 1 && captures.length == 1;
        return ExtractorCaptureOption(
          extractor: extractor,
          subtitle: selectDirectly
              ? _resolvedValueSubtitle(extractor, captures.single.value)
              : _secondaryText(
                  S
                      .of(context)
                      .notificationsDefinitionMatchCount(matches.length),
                ),
          onTap: () {
            if (selectDirectly) {
              _select(extractor, captures.single, matches.single.$1);
              return;
            }
            setState(() {
              _movingForward = true;
              _extractor = extractor;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _matchChoices(
    RegExpDefinition extractor,
    List<(int, RegExpMatch)> matches,
  ) => Column(
    key: const ValueKey<String>('capture-matches'),
    children: <Widget>[
      TextButton.icon(
        onPressed: () => setState(() {
          _movingForward = false;
          _extractor = null;
        }),
        icon: const Icon(Icons.arrow_back),
        label: Text(extractor.definitionName),
      ),
      ...matches.map(((int, RegExpMatch) entry) {
        final List<_Capture> captures = _capturesFor(extractor, entry.$2);
        final bool selectDirectly = captures.length == 1;
        return _choiceCard(
          icon: Icons.filter_1_outlined,
          title: selectDirectly
              ? _singleCaptureMatchTitle(entry.$1 + 1, captures.single.name)
              : Text(
                  S.of(context).notificationsExtractorMatchNumber(entry.$1 + 1),
                ),
          subtitle: selectDirectly
              ? _resolvedValueSubtitle(extractor, captures.single.value)
              : _secondaryText(
                  S.of(context).notificationsCaptureGroupCount(captures.length),
                ),
          onTap: () => selectDirectly
              ? _select(extractor, captures.single, entry.$1)
              : setState(() {
                  _movingForward = true;
                  _matchIndex = entry.$1;
                }),
        );
      }),
    ],
  );

  Widget _groupChoices(
    RegExpDefinition extractor,
    RegExpMatch match,
    int matchIndex,
  ) {
    final List<_Capture> captures = _capturesFor(extractor, match);
    return Column(
      key: const ValueKey<String>('capture-groups'),
      children: <Widget>[
        TextButton.icon(
          onPressed: () => setState(() {
            _movingForward = false;
            if (_matchesFor(extractor).length > 1) {
              _matchIndex = null;
            } else {
              _extractor = null;
            }
          }),
          icon: const Icon(Icons.arrow_back),
          label: Text(
            _matchIndex == null
                ? extractor.definitionName
                : S
                      .of(context)
                      .notificationsCaptureExtractorMatch(
                        extractor.definitionName,
                        matchIndex + 1,
                      ),
          ),
        ),
        ...captures.map(
          (_Capture capture) => _choiceCard(
            icon: Icons.text_fields_outlined,
            title: _groupTitle(capture.name),
            subtitle: _resolvedValueSubtitle(extractor, capture.value),
            onTap: () => _select(extractor, capture, matchIndex),
          ),
        ),
      ],
    );
  }

  Widget _choiceCard({
    required IconData icon,
    required Widget title,
    required Widget subtitle,
    required VoidCallback onTap,
  }) => DialogSelectorCard(
    margin: const EdgeInsets.only(bottom: 8),
    leading: Icon(icon),
    title: title,
    subtitle: subtitle,
    trailing: const Icon(Icons.chevron_right),
    onTap: onTap,
  );

  Widget _groupTitle(String groupName) => Text.rich(
    TextSpan(
      children: <InlineSpan>[
        TextSpan(text: S.of(context).notificationsCaptureGroupPrefix),
        TextSpan(
          text: groupName,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const TextSpan(text: '"'),
      ],
    ),
  );

  Widget _singleCaptureMatchTitle(int matchNumber, String groupName) =>
      Text.rich(
        TextSpan(
          style: Theme.of(context).textTheme.titleMedium,
          children: <InlineSpan>[
            TextSpan(
              text: S
                  .of(context)
                  .notificationsCaptureMatchGroupPrefix(matchNumber),
            ),
            TextSpan(
              text: groupName,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const TextSpan(text: '"'),
          ],
        ),
      );

  Widget _resolvedValueSubtitle(RegExpDefinition extractor, String value) =>
      _mixedText(<InlineSpan>[
        TextSpan(text: S.of(context).notificationsResolvedValuePrefix),
        _primaryTextSpan(_resolvedValueText(extractor, value)),
        const TextSpan(text: '"'),
      ]);

  Widget _secondaryText(String text) =>
      Text(text, style: context.notificationSupportingText);

  Widget _mixedText(List<InlineSpan> children) => Text.rich(
    TextSpan(
      style: TextStyle(color: Theme.of(context).colorScheme.outline),
      children: children,
    ),
  );

  TextSpan _primaryTextSpan(String text) => TextSpan(
    text: text,
    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
  );

  String _resolvedValueText(RegExpDefinition extractor, String value) {
    if (extractor.predefinedType !=
        PredefinedRegExpDefinition.notificationDate) {
      return value;
    }
    final DateTime? dateTime = DateTime.tryParse(value.trim());
    if (dateTime == null) return value;
    return formatNotificationDateTime(context, dateTime);
  }

  List<(int, RegExpMatch)> _matchesFor(RegExpDefinition extractor) => extractor
      .evaluate(widget.notificationContext)
      .matches
      .indexed
      .where(
        ((int, RegExpMatch) entry) =>
            _capturesFor(extractor, entry.$2).isNotEmpty,
      )
      .toList();

  List<_Capture> _capturesFor(RegExpDefinition extractor, RegExpMatch match) {
    final List<_Capture> namedCaptures = match.groupNames
        .map((String name) => _Capture(name, match.namedGroup(name)))
        .whereType<_Capture>()
        .where((_Capture capture) => _isAllowed(extractor, capture))
        .toList();
    if (namedCaptures.isNotEmpty) return namedCaptures;
    return List<_Capture?>.generate(
          match.groupCount,
          (int index) => _Capture('#${index + 1}', match.group(index + 1)),
        )
        .whereType<_Capture>()
        .where((_Capture capture) => _isAllowed(extractor, capture))
        .toList();
  }

  bool _isAllowed(RegExpDefinition extractor, _Capture capture) =>
      capture.value.isNotEmpty &&
      (widget.isCaptureAllowed?.call(extractor, capture.name, capture.value) ??
          true);

  void _select(RegExpDefinition extractor, _Capture capture, int matchIndex) =>
      widget.onSelected(
        ExtractorCaptureSelection(
          extractor: extractor,
          captureName: capture.fallbackCaptureIndex == null ? capture.name : '',
          fallbackCaptureIndex: capture.fallbackCaptureIndex,
          matchIndex: matchIndex,
          value: capture.value,
        ),
      );
}

class _Capture {
  const _Capture(this.name, String? value) : value = value ?? '';

  final String name;
  final String value;

  int? get fallbackCaptureIndex =>
      name.startsWith('#') ? int.tryParse(name.substring(1)) : null;
}
