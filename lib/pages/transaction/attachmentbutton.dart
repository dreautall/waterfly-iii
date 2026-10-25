import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

class AttachmentButton extends StatefulWidget {
  final List<AttachmentRead>? attachments;
  final Future<void> Function() onPressed;
  final bool saving;

  const AttachmentButton({
    super.key,
    required this.attachments,
    required this.onPressed,
    this.saving = false,
  });

  @override
  State<AttachmentButton> createState() => _AttachmentButtonState();
}

class _AttachmentButtonState extends State<AttachmentButton> {
  late bool _hasAttachments;

  final Logger log = Logger("Pages.Transaction.AttachmentButton");

  @override
  void initState() {
    super.initState();

    log.finest(() => "initState()");
    _hasAttachments = widget.attachments?.isNotEmpty ?? false;
  }

  @override
  void didUpdateWidget(covariant AttachmentButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    log.finest(() => "didUpdateWidget()");
    _hasAttachments = widget.attachments?.isNotEmpty ?? false;
    log.finest(() => "_hasAttachments: $_hasAttachments");
  }

  @override
  Widget build(BuildContext context) {
    log.finest(() => "build(${widget.attachments?.length ?? "null"})");

    return badges.Badge(
      badgeContent: Text(
        widget.attachments?.length.toString() ?? "..",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      showBadge: _hasAttachments,
      badgeStyle: badges.BadgeStyle(
        badgeColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(
        animationDuration: animDurationEmphasized,
        curve: animCurveEmphasized,
      ),
      child: MaterialIconButton(
        icon: Icons.attach_file,
        tooltip: S.of(context).transactionAttachments,
        onPressed: widget.saving ? null : widget.onPressed,
      ),
    );
  }
}
