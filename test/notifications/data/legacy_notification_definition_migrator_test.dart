import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/data/migrations/legacy_notification_definition_migrator.dart';
import 'package:waterflyiii/notifications/domain/actions/set_transaction_field_action.dart';
import 'package:waterflyiii/notifications/domain/alerts/notification_alert.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_definition.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';
import 'package:waterflyiii/notifications/domain/transactions/transaction_field.dart';
import 'package:waterflyiii/notifications/domain/value_sources/currency_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/firefly_resource_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/composed_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/normalized_amount_capture_value_source.dart';
import 'package:waterflyiii/notifications/domain/value_sources/reg_exp_capture_value_source.dart';

void main() {
  final LegacyNotificationDefinitionMigrator migrator =
      LegacyNotificationDefinitionMigrator();
  final NotificationSample sample = NotificationSample(
    title: 'Card payment',
    body: 'Paid USD 1 234,56',
    receivedAt: DateTime(2026, 8, 30),
  );

  test('migrates built-in settings into ordinary basic components', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{
        'appName': 'Example Bank',
        'defaultAccountId': '42',
        'includeTitle': true,
        'emptyNote': false,
        'autoAdd': false,
      },
      sample: sample,
      resolvedCurrency: const LegacyResolvedCurrency(
        token: 'USD',
        resourceId: 'currency-1',
      ),
    )!;
    final NotificationDefinition definition = result.definition;

    expect(definition.extractorMode, NotificationExtractorMode.basic);
    expect(
      definition.extractors.map(
        (RegExpDefinition extractor) => extractor.predefinedType,
      ),
      PredefinedRegExpDefinition.values,
    );
    expect(definition.sampleTitle, sample.title);
    expect(definition.sampleBody, sample.body);
    expect(definition.status, NotificationDefinitionStatus.ready);
    expect(result.reviewMessages, isEmpty);

    final List<SetTransactionFieldAction> actions = definition.sharedActions
        .whereType<SetTransactionFieldAction>()
        .toList();
    expect(
      actions
          .singleWhere(
            (SetTransactionFieldAction action) =>
                action.target == TransactionField.amount,
          )
          .valueSource,
      isA<NormalizedAmountCaptureValueSource>(),
    );
    final FireflyResourceValueSource account =
        actions
                .singleWhere(
                  (SetTransactionFieldAction action) =>
                      action.target == TransactionField.sourceAccount,
                )
                .valueSource
            as FireflyResourceValueSource;
    expect(account.resourceId, '42');
    expect(definition.rules, isEmpty);
    expect(
      actions
          .singleWhere(
            (SetTransactionFieldAction action) =>
                action.target == TransactionField.currency,
          )
          .valueSource,
      isA<CurrencyCaptureValueSource>(),
    );
    expect(
      definition
          .evaluate(sampleContext('com.example.bank', sample))
          ?.effectiveTransactionIntent
          ?.patch
          .values[TransactionField.currency],
      'currency-1',
    );
  });

  test('preserves the exact legacy title and notes behavior matrix', () {
    for (final (bool, bool, bool, String?, String?) example
        in <(bool, bool, bool, String?, String?)>[
          (false, true, false, 'Card payment', 'Paid USD 1 234,56'),
          (false, true, true, 'Card payment', null),
          (false, false, false, null, 'Card payment - Paid USD 1 234,56'),
          (false, false, true, null, 'Card payment - '),
          (true, false, true, 'Card payment', 'Paid USD 1 234,56'),
        ]) {
      final NotificationDefinition definition = migrator
          .migrate(
            'com.example.bank',
            <String, dynamic>{
              'appName': 'Example Bank',
              'autoAdd': example.$1,
              'includeTitle': example.$2,
              'emptyNote': example.$3,
            },
            sample: sample,
            resolvedCurrency: const LegacyResolvedCurrency(
              token: 'USD',
              resourceId: 'currency-1',
            ),
          )!
          .definition;
      final Map<TransactionField, String>? values = definition
          .evaluate(sampleContext('com.example.bank', sample))
          ?.effectiveTransactionIntent
          ?.patch
          .values;
      expect(values?[TransactionField.title], example.$4);
      expect(values?[TransactionField.notes], example.$5);
      if (!example.$1 && !example.$2) {
        expect(
          definition.sharedActions
              .whereType<SetTransactionFieldAction>()
              .singleWhere(
                (SetTransactionFieldAction action) =>
                    action.target == TransactionField.notes,
              )
              .valueSource,
          isA<ComposedValueSource>(),
        );
      }
    }
  });

  test(
    'custom regex migration includes predefined captures for built notes',
    () {
      final NotificationDefinition definition =
          migrator.migrate('com.example.bank', <String, dynamic>{
            'appName': 'Example Bank',
            'regex': r'(?<amount>\d+[.,]\d{2})',
            'includeTitle': false,
            'emptyNote': false,
          }, sample: sample)!.definition;

      expect(
        definition.extractors.map(
          (RegExpDefinition extractor) => extractor.predefinedType,
        ),
        containsAll(<PredefinedRegExpDefinition?>[
          null,
          PredefinedRegExpDefinition.notificationTitle,
          PredefinedRegExpDefinition.notificationMessage,
        ]),
      );
      expect(
        definition
            .evaluate(sampleContext('com.example.bank', sample))
            ?.effectiveTransactionIntent
            ?.patch
            .values[TransactionField.notes],
        'Card payment - Paid USD 1 234,56',
      );
    },
  );

  test('maps a uniquely resolved suffix currency', () {
    final NotificationSample suffixSample = NotificationSample(
      title: 'Card payment',
      body: 'Paid 12.50 EUR',
      receivedAt: DateTime(2026, 8, 30),
    );
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: suffixSample,
      resolvedCurrency: const LegacyResolvedCurrency(
        token: 'EUR',
        resourceId: 'currency-2',
      ),
    )!;

    expect(result.reviewMessages, isEmpty);
    expect(
      result.definition
          .evaluate(sampleContext('com.example.bank', suffixSample))
          ?.effectiveTransactionIntent
          ?.patch
          .values[TransactionField.currency],
      'currency-2',
    );
  });

  test('prefers a unique ISO code over an accompanying currency symbol', () {
    final NotificationSample mixedCurrencySample = NotificationSample(
      title: 'Card payment',
      body: r'Paid $12.50 CAD',
      receivedAt: DateTime(2026, 8, 30),
    );

    expect(
      migrator.currencyToken('com.example.bank', mixedCurrencySample),
      'CAD',
    );
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: mixedCurrencySample,
      resolvedCurrency: const LegacyResolvedCurrency(
        token: 'CAD',
        resourceId: 'currency-cad',
      ),
    )!;

    expect(result.reviewIssues, isEmpty);
    expect(result.definition.requiresMigrationReview, isFalse);
    final CurrencyCaptureValueSource source =
        result.definition.sharedActions
                .whereType<SetTransactionFieldAction>()
                .singleWhere(
                  (SetTransactionFieldAction action) =>
                      action.target == TransactionField.currency,
                )
                .valueSource
            as CurrencyCaptureValueSource;
    expect(source.capture.captureName, 'postCurrency');
    expect(source.expectedValue, 'CAD');
  });

  test('retains a repairable currency action for ambiguous ISO codes', () {
    final NotificationSample ambiguousCurrencySample = NotificationSample(
      title: 'Card payment',
      body: 'Paid USD 12.50 CAD',
      receivedAt: DateTime(2026, 8, 30),
    );

    expect(
      migrator.currencyToken('com.example.bank', ambiguousCurrencySample),
      isNull,
    );
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: ambiguousCurrencySample,
    )!;

    final SetTransactionFieldAction action = result.definition.sharedActions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    expect(action.valueSource, isA<RegExpCaptureValueSource>());
    expect(
      (action.valueSource as RegExpCaptureValueSource).captureName,
      'preCurrency',
    );
    expect(
      result.reviewIssues.map(
        (LegacyNotificationMigrationIssue issue) => issue.reason,
      ),
      contains(NotificationMigrationIssue.currencyUnresolved),
    );
  });

  test('does not require currency review without a currency candidate', () {
    final NotificationSample amountOnlySample = NotificationSample(
      title: 'Card payment',
      body: 'Paid 12.50',
      receivedAt: DateTime(2026, 8, 30),
    );
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: amountOnlySample,
    )!;

    expect(
      result.definition.sharedActions
          .whereType<SetTransactionFieldAction>()
          .where(
            (SetTransactionFieldAction action) =>
                action.target == TransactionField.currency,
          ),
      isEmpty,
    );
    expect(
      result.reviewIssues.map(
        (LegacyNotificationMigrationIssue issue) => issue.reason,
      ),
      isNot(contains(NotificationMigrationIssue.currencyUnresolved)),
    );
  });

  test('does not apply the sample currency to a later different token', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: sample,
      resolvedCurrency: const LegacyResolvedCurrency(
        token: 'USD',
        resourceId: 'currency-1',
      ),
    )!;

    final NotificationContext laterNotification = NotificationContext(
      applicationId: 'com.example.bank',
      title: 'Card payment',
      body: 'Paid EUR 12.50',
      receivedAt: DateTime(2026, 8, 31),
    );
    expect(
      result.definition
          .evaluate(laterNotification)
          ?.effectiveTransactionIntent
          ?.patch
          .values[TransactionField.currency],
      isNull,
    );
  });

  test('requires review when sample currency is not uniquely resolved', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: sample,
    )!;

    expect(result.definition.rules, isEmpty);
    final SetTransactionFieldAction currencyAction = result
        .definition
        .sharedActions
        .whereType<SetTransactionFieldAction>()
        .singleWhere(
          (SetTransactionFieldAction action) =>
              action.target == TransactionField.currency,
        );
    expect(currencyAction.target, TransactionField.currency);
    expect(currencyAction.valueSource, isA<RegExpCaptureValueSource>());
    expect(result.definition.extractorMode, NotificationExtractorMode.basic);
    expect(
      result.reviewMessages,
      contains(
        'Choose the transaction currency because it could not be resolved uniquely from the imported sample.',
      ),
    );
    expect(
      result.reviewIssues.single.reason,
      NotificationMigrationIssue.currencyUnresolved,
    );
    expect(result.definition.requiresMigrationReview, isTrue);
    expect(
      result.definition.migrationReviewIssues,
      contains(NotificationMigrationIssue.currencyUnresolved),
    );
    expect(
      result.definition
          .evaluate(sampleContext('com.example.bank', sample))
          ?.effectiveTransactionIntent,
      isNull,
    );
  });

  test('requires user input when no sample notification exists', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
    )!;

    expect(result.definition.status, NotificationDefinitionStatus.needsSetup);
    expect(
      result.reviewMessages,
      contains(
        'Enter a sample notification to finish the imported configuration.',
      ),
    );
    expect(
      result.reviewIssues.single.reason,
      NotificationMigrationIssue.sampleMissing,
    );
  });

  test('requires amount review when the sample has multiple values', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: NotificationSample(
        title: 'Card payment',
        body: 'Balance USD 2000.00, paid USD 12.50',
        receivedAt: DateTime(2026, 8, 30),
      ),
    )!;

    expect(result.definition.status, NotificationDefinitionStatus.needsReview);
    expect(
      result.reviewMessages,
      contains(
        'Choose the transaction amount because the imported sample contains multiple monetary values.',
      ),
    );
    expect(
      result.reviewIssues.first.reason,
      NotificationMigrationIssue.ambiguousAmount,
    );
  });

  test('ignores built-in notifications without required shared values', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank'},
      sample: sample,
    )!;

    expect(
      result.definition.evaluate(
        NotificationContext(
          applicationId: 'com.example.bank',
          title: 'Security notice',
          body: 'Your card settings were updated.',
          receivedAt: DateTime(2026, 9, 29),
        ),
      ),
      isNull,
    );
  });

  test('preserves a custom matcher with its first sample occurrence', () {
    final NotificationSample customSample = NotificationSample(
      title: 'Card payment',
      body: 'Balance 2000.00, paid 12.50',
      receivedAt: DateTime(2026, 8, 30),
    );
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{
        'appName': 'Example Bank',
        'regex': r'(?<amount>\d+\.\d{2})',
      },
      sample: customSample,
    )!;

    expect(result.definition.extractorMode, NotificationExtractorMode.advanced);
    expect(result.definition.status, NotificationDefinitionStatus.ready);
    expect(
      result.definition
          .evaluate(sampleContext('com.example.bank', customSample))
          ?.effectiveTransactionIntent
          ?.patch
          .values[TransactionField.amount],
      '2000.00',
    );
  });

  test('downgrades automatic creation until currency behavior is reviewed', () {
    final LegacyNotificationMigrationResult result = migrator.migrate(
      'com.example.bank',
      <String, dynamic>{'appName': 'Example Bank', 'autoAdd': true},
      sample: sample,
    )!;

    expect(
      result.definition.transactionCreationMode,
      TransactionCreationMode.prompt,
    );
    expect(
      result.reviewMessages,
      contains(
        'Automatic creation was changed to prompt mode until the imported currency behavior is reviewed.',
      ),
    );
    expect(
      result.reviewMessages,
      contains(
        'The imported automatic configuration is missing an account mapping. Review its shared actions before enabling automatic creation.',
      ),
    );
    expect(
      result.reviewIssues.map(
        (LegacyNotificationMigrationIssue issue) => issue.reason,
      ),
      containsAll(<NotificationMigrationIssue>[
        NotificationMigrationIssue.automaticCreationPaused,
        NotificationMigrationIssue.missingAutomaticAccount,
      ]),
    );
  });

  test('skips records without an application name', () {
    expect(migrator.migrate('com.example.bank', <String, dynamic>{}), isNull);
  });
}

NotificationContext sampleContext(
  String applicationId,
  NotificationSample sample,
) => NotificationContext(
  applicationId: applicationId,
  title: sample.title,
  body: sample.body,
  receivedAt: sample.receivedAt,
);
