import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_patch.dart';
import 'package:waterflyiii/notifications/domain/transactions/firefly_resource_reference.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_steps.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_value_dialog.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/transaction_field_value_formatter.dart';
import 'package:waterflyiii/notifications/presentation/shared/firefly_resource_label.dart';

class TransactionFieldProvenance {
  const TransactionFieldProvenance({required this.source, this.overrides});

  final String source;
  final String? overrides;
}

class TransactionPatchSummary extends StatelessWidget {
  const TransactionPatchSummary({
    super.key,
    required this.patch,
    this.fieldProvenance =
        const <TransactionField, TransactionFieldProvenance>{},
    this.tagProvenance,
  });

  final TransactionPatch patch;
  final Map<TransactionField, TransactionFieldProvenance> fieldProvenance;
  final TransactionFieldProvenance? tagProvenance;

  static const List<TransactionField> _accountFields = <TransactionField>[
    TransactionField.sourceAccount,
    TransactionField.destinationAccount,
  ];
  static const List<TransactionField> _classificationFields =
      <TransactionField>[
        TransactionField.category,
        TransactionField.currency,
        TransactionField.subscription,
        TransactionField.piggyBank,
      ];
  static const List<TransactionField> _additionalFields = <TransactionField>[
    TransactionField.date,
    TransactionField.time,
    TransactionField.notes,
  ];

  @override
  Widget build(BuildContext context) {
    final List<TransactionField> accounts = _presentFields(_accountFields);
    final List<TransactionField> classification = _presentFields(
      _classificationFields,
    );
    final List<TransactionField> additional = _presentFields(_additionalFields);
    final String? title = _primaryValue(TransactionField.title);
    final String? amount = _formattedAmount();
    final bool hasSummaryHeader = title != null || amount != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (hasSummaryHeader)
          _TransactionSummaryHeader(
            title: title,
            amount: amount,
            titleProvenance: fieldProvenance[TransactionField.title],
            amountProvenance: fieldProvenance[TransactionField.amount],
          ),
        _TransactionSummaryDetails(
          accounts: accounts,
          classification: classification,
          additional: additional,
          patch: patch,
          hasSummaryHeader: hasSummaryHeader,
          fieldProvenance: fieldProvenance,
          tagProvenance: tagProvenance,
        ),
      ],
    );
  }

  String? _primaryValue(TransactionField field) {
    if (!patch.values.containsKey(field)) return null;
    final String value = patch.displayValue(field).trim();
    return value.isEmpty ? null : value;
  }

  String? _formattedAmount() {
    final String? amount = _primaryValue(TransactionField.amount);
    if (amount == null) return null;
    final String? currencyCode = patch.currencyCodes[TransactionField.currency]
        ?.trim();
    return currencyCode == null || currencyCode.isEmpty
        ? amount
        : '$amount $currencyCode';
  }

  List<TransactionField> _presentFields(List<TransactionField> fields) => fields
      .where((TransactionField field) => patch.values.containsKey(field))
      .toList();
}

class _TransactionSummaryDetails extends StatelessWidget {
  const _TransactionSummaryDetails({
    required this.accounts,
    required this.classification,
    required this.additional,
    required this.patch,
    required this.hasSummaryHeader,
    required this.fieldProvenance,
    required this.tagProvenance,
  });

  final List<TransactionField> accounts;
  final List<TransactionField> classification;
  final List<TransactionField> additional;
  final TransactionPatch patch;
  final bool hasSummaryHeader;
  final Map<TransactionField, TransactionFieldProvenance> fieldProvenance;
  final TransactionFieldProvenance? tagProvenance;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      if (accounts.isNotEmpty) ...<Widget>[
        if (hasSummaryHeader) const SizedBox(height: 16),
        _TransactionDetailSection(
          title: S.of(context).notificationsTransactionAccounts,
          fields: accounts,
          patch: patch,
          provenance: fieldProvenance,
        ),
      ],
      if (classification.isNotEmpty) ...<Widget>[
        if (hasSummaryHeader || accounts.isNotEmpty) const SizedBox(height: 16),
        _TransactionDetailSection(
          title: S.of(context).notificationsTransactionClassification,
          fields: classification,
          patch: patch,
          provenance: fieldProvenance,
        ),
      ],
      if (additional.isNotEmpty) ...<Widget>[
        if (hasSummaryHeader ||
            accounts.isNotEmpty ||
            classification.isNotEmpty)
          const SizedBox(height: 16),
        _TransactionDetailSection(
          title: S.of(context).notificationsTransactionAdditionalDetails,
          fields: additional,
          patch: patch,
          provenance: fieldProvenance,
        ),
      ],
      if (patch.tags.isNotEmpty) ...<Widget>[
        if (hasSummaryHeader ||
            accounts.isNotEmpty ||
            classification.isNotEmpty ||
            additional.isNotEmpty)
          const SizedBox(height: 16),
        Text(
          transactionFieldLabel(context, TransactionField.tag),
          style: context.notificationMetadataText,
        ),
        if (tagProvenance != null) ...<Widget>[
          const SizedBox(height: 2),
          _TransactionProvenance(provenance: tagProvenance!),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: patch.tags
              .map(
                (String tag) => Chip(
                  avatar: const Icon(Icons.sell_outlined, size: 16),
                  label: Text(tag),
                  visualDensity: VisualDensity.compact,
                ),
              )
              .toList(),
        ),
      ],
    ],
  );
}

class _TransactionSummaryHeader extends StatelessWidget {
  const _TransactionSummaryHeader({
    this.title,
    this.amount,
    this.titleProvenance,
    this.amountProvenance,
  });

  final String? title;
  final String? amount;
  final TransactionFieldProvenance? titleProvenance;
  final TransactionFieldProvenance? amountProvenance;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool amountOnly = title == null && amount != null;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.receipt_long_outlined),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    amountOnly
                        ? transactionFieldLabel(
                            context,
                            TransactionField.amount,
                          )
                        : S.of(context).notificationsTransactionSummary,
                    style: context.notificationMetadataText,
                  ),
                  if (title != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (titleProvenance != null) ...<Widget>[
                      const SizedBox(height: 2),
                      _TransactionProvenance(provenance: titleProvenance!),
                    ],
                  ],
                ],
              ),
            ),
            if (amount != null) ...<Widget>[
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    amount!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (amountProvenance != null) ...<Widget>[
                    const SizedBox(height: 2),
                    _TransactionProvenance(
                      provenance: amountProvenance!,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TransactionDetailSection extends StatelessWidget {
  const _TransactionDetailSection({
    required this.title,
    required this.fields,
    required this.patch,
    required this.provenance,
  });

  final String title;
  final List<TransactionField> fields;
  final TransactionPatch patch;
  final Map<TransactionField, TransactionFieldProvenance> provenance;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(title, style: context.notificationMetadataText),
      const SizedBox(height: 4),
      for (int index = 0; index < fields.length; index++) ...<Widget>[
        _TransactionDetailRow(
          field: fields[index],
          patch: patch,
          provenance: provenance[fields[index]],
        ),
        if (index != fields.length - 1)
          Divider(
            height: 1,
            indent: 36,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
      ],
    ],
  );
}

class _TransactionDetailRow extends StatelessWidget {
  const _TransactionDetailRow({
    required this.field,
    required this.patch,
    this.provenance,
  });

  final TransactionField field;
  final TransactionPatch patch;
  final TransactionFieldProvenance? provenance;

  @override
  Widget build(BuildContext context) {
    final FireflyResourceReference? resourceReference =
        patch.resourceReferences[field];
    final Widget value = resourceReference == null
        ? Text(
            formatTransactionFieldValue(
              context,
              field,
              patch.displayValue(field),
            ),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        : FireflyResourceLabel.reference(
            resourceReference,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyLarge,
          );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        key: Key('transaction-field-${field.name}'),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(fieldIcon(field), size: 20),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transactionFieldLabel(context, field),
                  style: context.notificationMetadataText,
                ),
                if (provenance != null) ...<Widget>[
                  const SizedBox(height: 2),
                  _TransactionProvenance(provenance: provenance!),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(flex: 3, child: value),
        ],
      ),
    );
  }
}

class _TransactionProvenance extends StatelessWidget {
  const _TransactionProvenance({
    required this.provenance,
    this.textAlign = TextAlign.start,
  });

  final TransactionFieldProvenance provenance;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: textAlign == TextAlign.end
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        provenance.source,
        textAlign: textAlign,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      if (provenance.overrides != null) ...<Widget>[
        const SizedBox(height: 2),
        Text(
          provenance.overrides!,
          textAlign: textAlign,
          style: context.notificationMetadataText,
        ),
      ],
    ],
  );
}
