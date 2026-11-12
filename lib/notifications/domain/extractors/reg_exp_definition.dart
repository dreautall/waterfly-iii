import 'package:waterflyiii/notifications/domain/definitions/notification_context.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_evaluation_result.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_safety.dart';
import 'package:waterflyiii/notifications/domain/notification_id.dart';

enum RegExpDefinitionType { predefined, custom }

enum NotificationExtractorInput { title, body, receivedAt }

enum PredefinedRegExpDefinition {
  notificationTitle,
  notificationMessage,
  notificationDate,
  amount,
  currency,
}

extension PredefinedRegExpDefinitionDetails on PredefinedRegExpDefinition {
  String get displayName => switch (this) {
    PredefinedRegExpDefinition.notificationTitle => 'Notification title',
    PredefinedRegExpDefinition.notificationMessage => 'Notification message',
    PredefinedRegExpDefinition.notificationDate => 'Notification date and time',
    PredefinedRegExpDefinition.amount => 'Amount',
    PredefinedRegExpDefinition.currency => 'Currency',
  };

  NotificationExtractorInput get input => switch (this) {
    PredefinedRegExpDefinition.notificationTitle =>
      NotificationExtractorInput.title,
    PredefinedRegExpDefinition.notificationMessage =>
      NotificationExtractorInput.body,
    PredefinedRegExpDefinition.notificationDate =>
      NotificationExtractorInput.receivedAt,
    PredefinedRegExpDefinition.amount => NotificationExtractorInput.body,
    PredefinedRegExpDefinition.currency => NotificationExtractorInput.body,
  };

  String get source => switch (this) {
    PredefinedRegExpDefinition.notificationTitle => r'(?<title>[\s\S]+)',
    PredefinedRegExpDefinition.notificationMessage => r'(?<message>[\s\S]+)',
    PredefinedRegExpDefinition.notificationDate => r'(?<date>[\s\S]+)',
    PredefinedRegExpDefinition.amount =>
      r'(?:^|\s)(?=(?:(?:[A-Z]{3}|[A-Z]{0,2}[^\w\s\d.,]{1,3})\s*\d|\d(?:[.,\s\d]*\d)?\s*(?:[A-Z]{3}|[A-Z]{0,2}[^\w\s\d.,]{1,3})(?=$|\s|[.,])))(?:(?:[A-Z]{3}|[A-Z]{0,2}[^\w\s\d.,]{1,3})\s*)?(?<amount>\d(?:[.,\s\d]*\d)?)(?:\s*(?:[A-Z]{3}|[A-Z]{0,2}[^\w\s\d.,]{1,3}))?(?=$|\s|[.,])',
    PredefinedRegExpDefinition.currency =>
      r'(?:^|\s)(?=(?:(?:[A-Z]{3}|[^\w\s\d.,]{1,3})\s*\d|\d(?:[.,\s\d]*\d)?\s*(?:[A-Z]{3}|[^\w\s\d.,]{1,3})(?=$|\s|[.,])))(?<preCurrency>(?:[A-Z]{3}|[^\w\s\d.,]{1,3})?)\s*\d(?:[.,\s\d]*\d)?\s*(?<postCurrency>(?:[A-Z]{3}|[^\w\s\d.,]{1,3})?)(?=$|\s|[.,])',
  };

  String get defaultDescription => switch (this) {
    PredefinedRegExpDefinition.notificationTitle =>
      'Makes the notification title available to rules.',
    PredefinedRegExpDefinition.notificationMessage =>
      'Makes the notification message available to rules.',
    PredefinedRegExpDefinition.notificationDate =>
      'Makes the notification date and time available to rules.',
    PredefinedRegExpDefinition.amount =>
      'Finds a transaction amount in the notification message.',
    PredefinedRegExpDefinition.currency =>
      'Finds a currency code or symbol in the notification message.',
  };
}

final String predefinedRegExp = PredefinedRegExpDefinition.amount.source;

class RegExpDefinition {
  static const int maximumCustomInputLength = 16 * 1024;

  RegExpDefinition._(
    this.id,
    this.definitionName,
    this.description,
    this.regExpSource,
    this.type,
    this.isRequiredForMatch,
    this.predefinedType,
    this.sampleOverride,
  );

  static RegExpDefinition createPredefinedRegExpDefinition(
    PredefinedRegExpDefinition predefinedType, {
    String? description,
    bool isRequiredForMatch = false,
    NotificationSample? sampleOverride,
  }) {
    return RegExpDefinition._(
      _newId(),
      predefinedType.displayName,
      description ?? predefinedType.defaultDescription,
      predefinedType.source,
      RegExpDefinitionType.predefined,
      isRequiredForMatch,
      predefinedType,
      sampleOverride,
    );
  }

  static RegExpDefinition createCustomRegExpDefinition(
    String name,
    String source, {
    String description = '',
    bool isRequiredForMatch = false,
    NotificationSample? sampleOverride,
  }) {
    return RegExpDefinition._(
      _newId(),
      name,
      description,
      source,
      RegExpDefinitionType.custom,
      isRequiredForMatch,
      null,
      sampleOverride,
    );
  }

  final String id;
  final String definitionName;
  final String description;
  final String regExpSource;
  final RegExpDefinitionType type;
  final bool isRequiredForMatch;
  final PredefinedRegExpDefinition? predefinedType;
  final NotificationSample? sampleOverride;

  Set<RegExpSafetyIssue> get safetyIssues => type == RegExpDefinitionType.custom
      ? RegExpSafety.analyze(regExpSource)
      : const <RegExpSafetyIssue>{};

  RegExpDefinition copyWith({
    String? name,
    String? description,
    String? source,
    NotificationSample? sampleOverride,
  }) {
    return RegExpDefinition._(
      id,
      name ?? definitionName,
      description ?? this.description,
      source ?? regExpSource,
      type,
      isRequiredForMatch,
      predefinedType,
      sampleOverride ?? this.sampleOverride,
    );
  }

  RegExpDefinition withoutSampleOverride() => RegExpDefinition._(
    id,
    definitionName,
    description,
    regExpSource,
    type,
    isRequiredForMatch,
    predefinedType,
    null,
  );

  RegExpEvaluationResult evaluate(NotificationContext context) {
    if (regExpSource.isEmpty) {
      return const RegExpEvaluationResult(
        hasMatches: false,
        namedCaptures: <String, List<String>>{},
      );
    }

    final String input = _inputFor(context);
    if (type == RegExpDefinitionType.custom &&
        input.length > maximumCustomInputLength) {
      return const RegExpEvaluationResult(
        hasMatches: false,
        namedCaptures: <String, List<String>>{},
        error: 'Notification text is too long to evaluate safely.',
        failure: RegExpEvaluationFailure.inputTooLong,
      );
    }

    try {
      final List<RegExpMatch> matches = RegExp(
        regExpSource,
      ).allMatches(input).toList();
      return RegExpEvaluationResult(
        hasMatches: matches.isNotEmpty,
        namedCaptures: _namedCaptures(matches),
        positionalCaptures: _positionalCaptures(matches),
        matches: matches,
      );
    } on FormatException catch (error) {
      return RegExpEvaluationResult(
        hasMatches: false,
        namedCaptures: const <String, List<String>>{},
        error: error.message,
        failure: RegExpEvaluationFailure.invalidPattern,
      );
    }
  }

  String _inputFor(NotificationContext context) {
    return switch (predefinedType?.input ?? NotificationExtractorInput.body) {
      NotificationExtractorInput.title => context.title,
      NotificationExtractorInput.body => context.body,
      NotificationExtractorInput.receivedAt =>
        context.receivedAt.toIso8601String(),
    };
  }

  Map<String, List<String>> _namedCaptures(List<RegExpMatch> matches) {
    final Map<String, List<String>> captures = <String, List<String>>{};
    for (final RegExpMatch match in matches) {
      for (final String name in match.groupNames) {
        final String? value = match.namedGroup(name);
        if (value != null && value.isNotEmpty) {
          captures.putIfAbsent(name, () => <String>[]).add(value);
        }
      }
    }
    return captures;
  }

  Map<int, List<String>> _positionalCaptures(List<RegExpMatch> matches) {
    final Map<int, List<String>> captures = <int, List<String>>{};
    for (final RegExpMatch match in matches) {
      for (int index = 1; index <= match.groupCount; index += 1) {
        final String? value = match.group(index);
        if (value != null && value.isNotEmpty) {
          captures.putIfAbsent(index, () => <String>[]).add(value);
        }
      }
    }
    return captures;
  }

  factory RegExpDefinition.fromJson(Map<String, dynamic> json) {
    final RegExpDefinitionType type = RegExpDefinitionType.values.elementAt(
      json['type'] as int,
    );
    final PredefinedRegExpDefinition? predefinedType = _predefinedTypeFromJson(
      json,
    );
    return RegExpDefinition._(
      json['id'] as String? ?? _newId(),
      json['name'] as String,
      json['description'] as String? ??
          predefinedType?.defaultDescription ??
          '',
      predefinedType?.source ?? json['source'] as String,
      type,
      json['isRequiredForMatch'] as bool? ?? false,
      predefinedType,
      switch (json['sampleOverride']) {
        final Map<String, dynamic> sample => NotificationSample.fromJson(
          sample,
        ),
        _ => null,
      },
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': definitionName,
    if (description.isNotEmpty) 'description': description,
    'source': regExpSource,
    'type': type.index,
    'isRequiredForMatch': isRequiredForMatch,
    if (predefinedType != null) 'predefinedType': predefinedType!.name,
    if (sampleOverride != null) 'sampleOverride': sampleOverride!.toJson(),
  };

  static PredefinedRegExpDefinition? _predefinedTypeFromJson(
    Map<String, dynamic> json,
  ) {
    if (json['type'] as int != RegExpDefinitionType.predefined.index) {
      return null;
    }
    final String? name = json['predefinedType'] as String?;
    if (name == null) {
      // Predefined extractors saved before presets were introduced used one
      // combined amount/currency pattern, which must remain intact for rules.
      return null;
    }
    return PredefinedRegExpDefinition.values.byName(name);
  }

  static String _newId() => newNotificationId();
}
