import 'package:flutter_test/flutter_test.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/extractors/controllers/notification_extractor_editor_view_model.dart';

void main() {
  final NotificationContext context = NotificationContext(
    title: 'Card payment',
    body: 'Paid 12.50 CAD',
    receivedAt: DateTime(2026, 9, 8),
  );

  test('evaluates advanced extractor edits and validates an empty name', () {
    final NotificationExtractorEditorViewModel viewModel =
        NotificationExtractorEditorViewModel(
          extractor: RegExpDefinition.createCustomRegExpDefinition(
            'Amount',
            r'(?<amount>\d+\.\d+)',
          ),
          notificationContext: context,
          isAdvancedMode: true,
        );

    viewModel.evaluate();
    expect(viewModel.evaluation?.hasMatches, isTrue);

    viewModel.update(
      name: '',
      description: 'Finds the transaction amount.',
      source: r'(?<amount>\d+)',
    );
    expect(viewModel.isDirty, isTrue);
    expect(viewModel.evaluation?.hasMatches, isTrue);
    expect(viewModel.save(), isNull);
    expect(viewModel.validationError, 'An extractor name is required.');
    expect(
      viewModel.currentExtractor.description,
      'Finds the transaction amount.',
    );
  });

  test('evaluates against an updated notification context', () {
    final NotificationExtractorEditorViewModel viewModel =
        NotificationExtractorEditorViewModel(
          extractor: RegExpDefinition.createCustomRegExpDefinition(
            'Amount',
            r'(?<amount>\d+)',
          ),
          notificationContext: NotificationContext(
            title: 'No payment',
            body: 'No amount included.',
            receivedAt: DateTime(2026, 9, 23),
          ),
          isAdvancedMode: true,
        );

    viewModel.evaluate();
    expect(viewModel.evaluation!.hasMatches, isFalse);

    viewModel.updateSample(
      NotificationSample(
        title: 'Payment received',
        body: 'Paid 42 CAD.',
        receivedAt: DateTime(2026, 9, 23),
      ),
    );

    expect(viewModel.evaluation!.hasMatches, isTrue);
  });

  test(
    'owns sample override dirty state and applies it to the saved draft',
    () {
      final NotificationSample originalSample = NotificationSample(
        title: 'Card payment',
        body: 'Paid 12.50 CAD',
        receivedAt: DateTime(2026, 9, 8),
      );
      final NotificationExtractorEditorViewModel viewModel =
          NotificationExtractorEditorViewModel(
            extractor: RegExpDefinition.createCustomRegExpDefinition(
              'Amount',
              r'(?<amount>\d+\.\d+)',
            ).copyWith(sampleOverride: originalSample),
            notificationContext: context,
            isAdvancedMode: true,
            sampleOverride: originalSample,
            definitionSample: originalSample,
          );

      expect(viewModel.isDirty, isFalse);

      final NotificationSample replacement = NotificationSample(
        title: 'Transfer',
        body: 'Sent 42.00 CAD',
        receivedAt: DateTime(2026, 9, 23),
      );
      viewModel.updateSample(replacement);

      expect(viewModel.isDirty, isTrue);
      expect(viewModel.evaluation?.hasMatches, isTrue);
      expect(viewModel.save()?.sampleOverride?.body, 'Sent 42.00 CAD');

      viewModel.clearSampleOverride();
      expect(viewModel.sample.body, context.body);
      expect(viewModel.save()?.sampleOverride, isNull);
    },
  );
}
