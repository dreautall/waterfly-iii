import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/application/resources/firefly_currency_resolver.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/actions/transaction_action_controller.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/values/extractor_capture_picker.dart';
import 'package:waterflyiii/notifications/presentation/dialogs/values/firefly_resource_picker.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_expander_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/dialog_selector_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_empty_state.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/widgets/firefly_transaction_title_autocomplete.dart';

class ActionFieldStep extends StatelessWidget {
  const ActionFieldStep({
    super.key,
    required this.unavailableFields,
    required this.optionalFields,
    required this.onSelected,
  });

  final Set<TransactionField> unavailableFields;
  final Set<TransactionField>? optionalFields;
  final ValueChanged<TransactionField> onSelected;

  @override
  Widget build(BuildContext context) {
    final List<TransactionField> fields =
        <TransactionField>[
          ...?optionalFields,
          if (optionalFields == null) ...TransactionField.values,
        ]..sort(
          (TransactionField first, TransactionField second) =>
              actionTransactionFieldLabel(
                context,
                first,
              ).toLowerCase().compareTo(
                actionTransactionFieldLabel(context, second).toLowerCase(),
              ),
        );
    return ListView(
      key: ValueKey<String>(
        optionalFields == null ? 'fields' : 'optional-predefined-fields',
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(4),
      children: fields.map((TransactionField field) {
        final bool unavailable = unavailableFields.contains(field);
        return DialogSelectorCard(
          margin: const EdgeInsets.only(bottom: 8),
          leading: Icon(fieldIcon(field)),
          title: Text(actionTransactionFieldLabel(context, field)),
          subtitle: Text(
            unavailable
                ? optionalFields == null
                      ? S.of(context).notificationsActionAlreadySet
                      : S.of(context).notificationsRuleAlreadyAdded
                : fieldDescription(context, field),
            style: context.notificationSupportingText,
          ),
          trailing: unavailable ? null : const Icon(Icons.chevron_right),
          onTap: unavailable ? null : () => onSelected(field),
        );
      }).toList(),
    );
  }
}

class ActionSourceStep extends StatelessWidget {
  const ActionSourceStep({
    super.key,
    required this.field,
    required this.sourceMode,
    required this.extractors,
    required this.notificationContext,
    required this.captureOnly,
    required this.allowFireflyResource,
    required this.literalController,
    required this.literalFocusNode,
    required this.literalError,
    required this.titleSuggestionLoader,
    required this.onLiteralChanged,
    required this.onModeChanged,
    required this.isCaptureAllowed,
    required this.onCaptureSelected,
    required this.onResourceSelected,
    required this.onPickDate,
    required this.onPickTime,
    required this.onBuildText,
  });

  final TransactionField field;
  final TransactionActionSourceMode? sourceMode;
  final List<RegExpDefinition> extractors;
  final NotificationContext notificationContext;
  final bool captureOnly;
  final bool allowFireflyResource;
  final TextEditingController literalController;
  final FocusNode literalFocusNode;
  final String? literalError;
  final TransactionTitleSuggestionLoader? titleSuggestionLoader;
  final ValueChanged<String> onLiteralChanged;
  final ValueChanged<TransactionActionSourceMode?> onModeChanged;
  final bool Function(RegExpDefinition, String, String) isCaptureAllowed;
  final ValueChanged<ExtractorCaptureSelection> onCaptureSelected;
  final ValueChanged<FireflyResourceValueSource> onResourceSelected;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;
  final VoidCallback onBuildText;

  @override
  Widget build(BuildContext context) {
    final TransactionFieldSpec spec = TransactionFieldSpec.values[field]!;
    return ListView(
      key: ValueKey<String>('source-${field.name}'),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(4),
      children: <Widget>[
        if (spec.allowedSources.contains(
          TransactionFieldSourceKind.extractorCapture,
        ))
          _ActionSourceOption(
            mode: TransactionActionSourceMode.capture,
            selectedMode: sourceMode,
            icon: Icons.text_fields_outlined,
            title: S.of(context).notificationsActionExtractorCapture,
            subtitle: S
                .of(context)
                .notificationsActionExtractorCaptureDescription,
            onModeChanged: onModeChanged,
            child: ExtractorCapturePicker(
              extractors: extractors,
              notificationContext: notificationContext,
              isCaptureAllowed: isCaptureAllowed,
              onSelected: onCaptureSelected,
            ),
          ),
        if (!captureOnly &&
            spec.allowedSources.contains(TransactionFieldSourceKind.literal))
          _ActionSourceOption(
            mode: TransactionActionSourceMode.literal,
            selectedMode: sourceMode,
            icon: Icons.edit_outlined,
            title: S.of(context).notificationsActionLiteralValue,
            subtitle: S.of(context).notificationsActionLiteralDescription,
            onModeChanged: onModeChanged,
            onExpanded: literalFocusNode.requestFocus,
            child: field == TransactionField.title
                ? FireflyTransactionTitleAutocomplete(
                    fieldKey: const Key('action-literal-value'),
                    textController: literalController,
                    focusNode: literalFocusNode,
                    labelText: S.of(context).notificationsActionLiteralValue,
                    errorText: literalError,
                    suggestionLoader: titleSuggestionLoader,
                    onChanged: onLiteralChanged,
                  )
                : TextField(
                    key: const Key('action-literal-value'),
                    controller: literalController,
                    focusNode: literalFocusNode,
                    onChanged: onLiteralChanged,
                    keyboardType: fieldKeyboardType(field),
                    inputFormatters: fieldInputFormatters(field),
                    decoration: notificationInputDecoration(
                      context,
                      labelText: S.of(context).notificationsActionLiteralValue,
                      errorText: literalError,
                      suffixIcon: switch (field) {
                        TransactionField.date => IconButton(
                          tooltip: S.of(context).notificationsActionChooseDate,
                          onPressed: onPickDate,
                          icon: const Icon(Icons.calendar_today_outlined),
                        ),
                        TransactionField.time => IconButton(
                          tooltip: S.of(context).notificationsActionChooseTime,
                          onPressed: onPickTime,
                          icon: const Icon(Icons.schedule_outlined),
                        ),
                        _ => null,
                      },
                    ),
                  ),
          ),
        if (!captureOnly &&
            allowFireflyResource &&
            spec.allowedSources.contains(
              TransactionFieldSourceKind.fireflyResource,
            ))
          _ActionSourceOption(
            mode: TransactionActionSourceMode.firefly,
            selectedMode: sourceMode,
            icon: Icons.search_outlined,
            title: S.of(context).notificationsActionSelectFirefly,
            subtitle: S.of(context).notificationsActionFireflyDescription,
            onModeChanged: onModeChanged,
            child: spec.resourceKind == null
                ? const SizedBox.shrink()
                : FireflyResourcePicker(
                    resourceKind: spec.resourceKind!,
                    onSelected: onResourceSelected,
                  ),
          ),
        if (!captureOnly &&
            (field == TransactionField.title ||
                field == TransactionField.notes))
          DialogSelectorCard(
            key: const Key('action-build-text'),
            margin: const EdgeInsets.only(bottom: 8),
            leading: const Icon(Icons.segment_outlined),
            title: Text(S.of(context).notificationsActionBuildText),
            subtitle: Text(
              S.of(context).notificationsActionBuildTextDescription,
              style: context.notificationSupportingText,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: onBuildText,
          ),
      ],
    );
  }
}

class ActionCurrencyMatchStep extends StatelessWidget {
  const ActionCurrencyMatchStep({
    super.key,
    required this.extractedValue,
    required this.searchController,
    required this.matches,
    required this.onSearchChanged,
    required this.onSelected,
  });

  final String? extractedValue;
  final TextEditingController searchController;
  final Future<Iterable<FireflyCurrency>>? matches;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<FireflyCurrency> onSelected;

  @override
  Widget build(BuildContext context) => ListView(
    key: const ValueKey<String>('currency-match'),
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.all(4),
    children: <Widget>[
      Text(
        S
            .of(context)
            .notificationsActionExtractedCurrency(
              extractedValue ?? S.of(context).notificationsActionNoValue,
            ),
        style: context.notificationSectionDescription,
      ),
      const SizedBox(height: 16),
      TextField(
        controller: searchController,
        autofocus: true,
        decoration: notificationInputDecoration(
          context,
          labelText: S.of(context).notificationsActionSearchCurrencies,
          prefixIcon: const Icon(Icons.search_outlined),
        ),
        onChanged: onSearchChanged,
      ),
      const SizedBox(height: 12),
      FutureBuilder<Iterable<FireflyCurrency>>(
        future: matches,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Iterable<FireflyCurrency>> snapshot,
            ) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(
                  S.of(context).notificationsActionCurrenciesLoadFailure,
                );
              }
              final List<FireflyCurrency> currencies =
                  snapshot.data?.toList() ?? const <FireflyCurrency>[];
              if (currencies.isEmpty) {
                return NotificationInlineEmptyState(
                  message: S.of(context).notificationsActionNoCurrencies,
                );
              }
              return Column(
                children: currencies
                    .map(
                      (FireflyCurrency currency) => DialogSelectorCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        leading: const Icon(Icons.currency_exchange_outlined),
                        title: Text(currency.name),
                        subtitle: Text(
                          '${currency.code} ${currency.symbol}',
                          style: context.notificationSupportingText,
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => onSelected(currency),
                      ),
                    )
                    .toList(),
              );
            },
      ),
    ],
  );
}

class _ActionSourceOption extends StatelessWidget {
  const _ActionSourceOption({
    required this.mode,
    required this.selectedMode,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onModeChanged,
    required this.child,
    this.onExpanded,
  });

  final TransactionActionSourceMode mode;
  final TransactionActionSourceMode? selectedMode;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<TransactionActionSourceMode?> onModeChanged;
  final Widget child;
  final VoidCallback? onExpanded;

  @override
  Widget build(BuildContext context) {
    final bool expanded = selectedMode == mode;
    return DialogExpanderCard(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle, style: context.notificationSupportingText),
      expanded: expanded,
      onTap: () => onModeChanged(expanded ? null : mode),
      onExpanded: onExpanded,
      belly: child,
    );
  }
}

IconData actionStepIcon(TransactionActionStep step, TransactionField? field) =>
    switch (step) {
      TransactionActionStep.field => Icons.account_tree_outlined,
      TransactionActionStep.currencyMatch => Icons.currency_exchange_outlined,
      TransactionActionStep.source => Icons.tune_outlined,
      TransactionActionStep.buildText => Icons.segment_outlined,
      TransactionActionStep.tags => Icons.sell_outlined,
    };

String actionTransactionFieldLabel(
  BuildContext context,
  TransactionField field,
) => switch (field) {
  TransactionField.title => S.of(context).notificationsFieldTitle,
  TransactionField.amount => S.of(context).notificationsFieldAmount,
  TransactionField.date => S.of(context).notificationsFieldDate,
  TransactionField.time => S.of(context).notificationsFieldTime,
  TransactionField.sourceAccount =>
    S.of(context).notificationsFieldSourceAccount,
  TransactionField.destinationAccount =>
    S.of(context).notificationsFieldDestinationAccount,
  TransactionField.category => S.of(context).notificationsFieldCategory,
  TransactionField.tag => S.of(context).notificationsFieldTags,
  TransactionField.notes => S.of(context).notificationsFieldNotes,
  TransactionField.subscription => S.of(context).notificationsFieldSubscription,
  TransactionField.currency => S.of(context).notificationsFieldCurrency,
  TransactionField.piggyBank => S.of(context).notificationsFieldPiggyBank,
};

IconData fieldIcon(TransactionField field) => switch (field) {
  TransactionField.amount => Icons.payments_outlined,
  TransactionField.date || TransactionField.time => Icons.schedule_outlined,
  TransactionField.sourceAccount ||
  TransactionField.destinationAccount => Icons.account_balance_outlined,
  TransactionField.category => Icons.category_outlined,
  TransactionField.tag => Icons.sell_outlined,
  TransactionField.notes => Icons.notes_outlined,
  TransactionField.subscription => Icons.repeat_outlined,
  TransactionField.currency => Icons.currency_exchange_outlined,
  TransactionField.piggyBank => Icons.savings_outlined,
  TransactionField.title => Icons.title_outlined,
};

String fieldDescription(
  BuildContext context,
  TransactionField field,
) => switch (field) {
  TransactionField.title => S.of(context).notificationsFieldTitleDescription,
  TransactionField.amount => S.of(context).notificationsFieldAmountDescription,
  TransactionField.date => S.of(context).notificationsFieldDateDescription,
  TransactionField.time => S.of(context).notificationsFieldTimeDescription,
  TransactionField.sourceAccount =>
    S.of(context).notificationsFieldSourceAccountDescription,
  TransactionField.destinationAccount =>
    S.of(context).notificationsFieldDestinationAccountDescription,
  TransactionField.category =>
    S.of(context).notificationsFieldCategoryDescription,
  TransactionField.tag => S.of(context).notificationsFieldTagsDescription,
  TransactionField.notes => S.of(context).notificationsFieldNotesDescription,
  TransactionField.subscription =>
    S.of(context).notificationsFieldSubscriptionDescription,
  TransactionField.currency =>
    S.of(context).notificationsFieldCurrencyDescription,
  TransactionField.piggyBank =>
    S.of(context).notificationsFieldPiggyBankDescription,
};

TextInputType fieldKeyboardType(TransactionField field) => switch (field) {
  TransactionField.amount => const TextInputType.numberWithOptions(
    decimal: true,
  ),
  TransactionField.date || TransactionField.time => TextInputType.datetime,
  _ => TextInputType.text,
};

List<TextInputFormatter> fieldInputFormatters(TransactionField field) =>
    switch (field) {
      TransactionField.amount => <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\s]')),
      ],
      TransactionField.date => <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
      ],
      TransactionField.time => <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9:]')),
      ],
      _ => const <TextInputFormatter>[],
    };
