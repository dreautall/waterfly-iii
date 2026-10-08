import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/domain/planning/automatic_transaction_readiness.dart';
import 'package:waterflyiii/notifications/presentation/definitions/widgets/automatic_transaction_readiness_display.dart';
import 'package:waterflyiii/notifications/presentation/shared/message_status_card.dart';

class DefinitionOptionsSection extends StatefulWidget {
  const DefinitionOptionsSection({
    super.key,
    required this.createAutomatically,
    required this.onCreateAutomaticallyChanged,
    required this.automaticReadiness,
    this.warningKey,
    this.onWarningRevealed,
  });

  final bool createAutomatically;
  final ValueChanged<bool> onCreateAutomaticallyChanged;
  final AutomaticTransactionReadiness automaticReadiness;
  final Key? warningKey;
  final VoidCallback? onWarningRevealed;

  @override
  State<DefinitionOptionsSection> createState() =>
      _DefinitionOptionsSectionState();
}

class _DefinitionOptionsSectionState extends State<DefinitionOptionsSection> {
  static const Duration _warningDuration = Duration(milliseconds: 200);
  static const Duration _fadeDuration = Duration(milliseconds: 140);

  bool get _shouldShowWarning =>
      widget.createAutomatically && !widget.automaticReadiness.isReady;

  late bool _showWarning = _shouldShowWarning;
  late bool _revealWarning = _shouldShowWarning;

  @override
  void didUpdateWidget(covariant DefinitionOptionsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool previouslyShowedWarning =
        oldWidget.createAutomatically && !oldWidget.automaticReadiness.isReady;
    if (_shouldShowWarning && !previouslyShowedWarning) {
      _showWarning = true;
      _revealWarning = false;
      WidgetsBinding.instance.addPostFrameCallback((Duration _) {
        if (mounted && _shouldShowWarning) {
          setState(() => _revealWarning = true);
        }
      });
    } else if (!_shouldShowWarning && previouslyShowedWarning) {
      _revealWarning = false;
    }
  }

  void _handleWarningAnimationEnd() {
    if (_revealWarning && _shouldShowWarning) {
      widget.onWarningRevealed?.call();
    } else if (!_shouldShowWarning && _showWarning) {
      setState(() => _showWarning = false);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        S.of(context).notificationsDefinitionOptionsHeading,
        style: context.notificationSectionTitle,
      ),
      const SizedBox(height: 4),
      Text(
        S.of(context).notificationsDefinitionOptionsDescription,
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 12),
      DefinitionDetailCard(
        leading: const Icon(Icons.bolt_outlined),
        title: Text(S.of(context).notificationsDefinitionCreateAutomatically),
        subtitle: Text(
          widget.createAutomatically
              ? S.of(context).notificationsDefinitionCreateAutomaticallyEnabled
              : S
                    .of(context)
                    .notificationsDefinitionCreateAutomaticallyDisabled,
          style: context.notificationSupportingText,
        ),
        trailing: Checkbox(
          value: widget.createAutomatically,
          onChanged: (bool? value) {
            if (value != null) {
              widget.onCreateAutomaticallyChanged(value);
            }
          },
        ),
        onTap: () =>
            widget.onCreateAutomaticallyChanged(!widget.createAutomatically),
      ),
      if (_showWarning)
        ClipRect(
          child: AnimatedAlign(
            duration: _warningDuration,
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            heightFactor: _revealWarning ? 1 : 0,
            onEnd: _handleWarningAnimationEnd,
            child: AnimatedOpacity(
              duration: _fadeDuration,
              curve: Curves.easeIn,
              opacity: _revealWarning ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: MessageStatusCard(
                  key: widget.warningKey,
                  status: MessageStatus.review,
                  title: S
                      .of(context)
                      .notificationsDefinitionAutomaticIncompleteTitle,
                  message: widget.automaticReadiness.message(context),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
