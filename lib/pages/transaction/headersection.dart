import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:waterflyiii/animations.dart';
import 'package:waterflyiii/extensions.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';
import 'package:waterflyiii/pages/transaction/dialogs/attachments.dart';
import 'package:waterflyiii/pages/transaction/state.dart';
import 'package:waterflyiii/pages/transaction/title.dart';
import 'package:waterflyiii/widgets/input_number.dart';
import 'package:waterflyiii/widgets/materialiconbutton.dart';

final Logger log = Logger("Pages.Transaction.TransactionHeaderSection");

class TransactionHeaderSection extends StatelessWidget {
  final TransactionState tx;
  final TextEditingController totalAmountTC;
  final FocusNode totalAmountFN;
  final bool saving;
  final bool readOnly;

  const TransactionHeaderSection({
    super.key,
    required this.tx,
    required this.totalAmountTC,
    required this.totalAmountFN,
    required this.saving,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    log.finest("build()");
    final bool isSplit = tx.split;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildTitle(context, isSplit),
            const SizedBox(width: 12),
            _buildAttachmentButton(context),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            children: <Widget>[
              _buildAmount(context, isSplit),
              const SizedBox(width: 16),
              _buildDate(context),
              const SizedBox(width: 16),
              _buildTime(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, bool isSplit) {
    if (isSplit) {
      return TransactionTitle(
        textController: tx.groupTitleTC,
        focusNode: tx.groupTitleFN,
      );
    } else {
      final TransactionSplitState split = tx.splits.first;

      return TransactionTitle(
        textController: split.titleTC,
        focusNode: split.titleFN,
      );
    }
  }

  Widget _buildAttachmentButton(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(
        tx.attachments == null ? ".." : tx.attachments!.length.toString(),
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      showBadge: tx.hasAttachments,
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
        onPressed: () async {
          final List<AttachmentRead> dialogAttachments =
              tx.attachments ?? <AttachmentRead>[];
          await showDialog<List<AttachmentRead>>(
            context: context,
            builder: (BuildContext context) => AttachmentDialog(
              attachments: dialogAttachments,
              transactionId: tx.splits.first.journalID,
            ),
          );
          tx.attachments = dialogAttachments;
        },
      ),
    );
  }

  Widget _buildAmount(BuildContext context, bool isSplit) {
    if (tx.splits.isEmpty) {
      return const SizedBox.shrink();
    }

    late final Widget input;

    if (!isSplit) {
      // SINGLE TX --> editable
      final TransactionSplitState split = tx.splits.first;

      input = _buildNumberInput(
        controller: split.localAmountTC,
        enabled: !saving && !readOnly,
        onChanged: (String val) {
          log.finest(() => "_buildAmount: onChanged($val)");
          split.localAmount = double.tryParse(val) ?? 0;
        },
        currency: tx.localCurrency,
      );
    } else {
      // SPLIT TX --> derived total (readonly)
      input = _buildNumberInput(
        controller: totalAmountTC,
        enabled: false,
        currency: tx.localCurrency,
      );
    }
    return SizedBox(width: 135, child: input);
  }

  Widget _buildNumberInput({
    required TextEditingController controller,
    required bool enabled,
    void Function(String)? onChanged,
    required CurrencyRead currency,
  }) {
    return NumberInput(
      icon: SizedBox(
        width: 24,
        height: 32,
        child: FittedBox(child: Text(currency.attributes.symbol)),
      ),
      hintText: currency.zero(),
      decimals: currency.attributes.decimalPlaces ?? 2,
      controller: controller,
      disabled: !enabled,
      onChanged: onChanged,
    );
  }

  Widget _buildDate(BuildContext context) => IntrinsicWidth(
    child: TextFormField(
      controller: tx.dateTC,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      readOnly: true,
      enabled: !saving,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: tx.date,
          locale: Locale(
            Intl.defaultLocale!.split("_").first,
            Intl.defaultLocale!.split("_").last,
          ),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate == null) {
          return;
        }

        tx.date = tz.TZDateTime.from(
          tx.date.copyWith(
            year: pickedDate.year,
            month: pickedDate.month,
            day: pickedDate.day,
          ),
          tx.date.location,
        );
      },
    ),
  );

  Widget _buildTime(BuildContext context) => IntrinsicWidth(
    child: TextFormField(
      controller: tx.timeTC,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      readOnly: true,
      enabled: !saving,
      onTap: () async {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: tx.date.getTimeOfDay(),
        );

        if (pickedTime == null) {
          return;
        }

        tx.date = tx.date.setTimeOfDay(pickedTime);
      },
    ),
  );
}
