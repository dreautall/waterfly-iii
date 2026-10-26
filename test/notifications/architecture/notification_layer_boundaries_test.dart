import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('notification domain does not depend on outer layers', () async {
    await _expectNoImportsFrom(
      directory: 'lib/notifications/domain',
      forbiddenImports: <String>[
        'package:waterflyiii/notifications/application/',
        'package:waterflyiii/notifications/data/',
        'package:waterflyiii/notifications/presentation/',
      ],
    );
  });

  test(
    'notification application does not depend on data or presentation',
    () async {
      await _expectNoImportsFrom(
        directory: 'lib/notifications/application',
        forbiddenImports: <String>[
          'package:waterflyiii/notifications/data/',
          'package:waterflyiii/notifications/presentation/',
          'package:flutter/',
          'package:waterflyiii/settings.dart',
        ],
      );
    },
  );

  test('notification presentation does not depend on feature data', () async {
    await _expectNoImportsFrom(
      directory: 'lib/notifications/presentation',
      forbiddenImports: <String>['package:waterflyiii/notifications/data/'],
    );
  });

  test(
    'notification presentation controllers depend only on inner layers',
    () async {
      await _expectNoImportsFrom(
        directory: 'lib/notifications/presentation',
        forbiddenImports: <String>['package:waterflyiii/notifications/data/'],
        pathSegment:
            '${Platform.pathSeparator}controllers${Platform.pathSeparator}',
      );
    },
  );

  test('notification editor workflows do not construct domain drafts', () async {
    await _expectNoSourcePatterns(
      file:
          'lib/notifications/presentation/definitions/widgets/definition_editor_workflows.dart',
      forbiddenPatterns: <RegExp>[
        RegExp(r'NotificationRule\('),
        RegExp(r'RegExpDefinition\.create'),
      ],
    );
    await _expectNoSourcePatterns(
      file:
          'lib/notifications/presentation/rules/widgets/rule_action_editor.dart',
      forbiddenPatterns: <RegExp>[
        RegExp(r'SetTransactionFieldAction\(\s*target:'),
        RegExp(r'RegExpCaptureValueSource\('),
      ],
    );
  });

  test(
    'notification rule presentation does not mutate editor collections',
    () async {
      await _expectNoSourcePatterns(
        file: 'lib/notifications/presentation/rules',
        forbiddenPatterns: <RegExp>[
          RegExp(r'_conditions\s*\[.*?\]\s*='),
          RegExp(r'_conditions\.(?:add|remove|removeAt|insert)\('),
          RegExp(r'_actions\s*\[.*?\]\s*='),
          RegExp(r'_actions\.(?:add|remove|removeAt|insert)\('),
          RegExp(r'_reviewedPredefinedFields\.(?:add|remove)\('),
        ],
      );
    },
  );

  test('notification rule presentation uses independent modules', () async {
    await _expectNoSourcePatterns(
      file: 'lib/notifications/presentation/rules',
      forbiddenPatterns: <RegExp>[
        RegExp(r'^\s*part(?:\s+of)?\s', multiLine: true),
      ],
    );
  });
}

Future<void> _expectNoImportsFrom({
  required String directory,
  required List<String> forbiddenImports,
  String? pathSegment,
}) async {
  final Directory sourceDirectory = Directory(directory);
  final List<File> sourceFiles = sourceDirectory
      .listSync(recursive: true)
      .whereType<File>()
      .where((File file) => file.path.endsWith('.dart'))
      .where(
        (File file) => pathSegment == null || file.path.contains(pathSegment),
      )
      .toList();
  for (final File sourceFile in sourceFiles) {
    final String source = await sourceFile.readAsString();
    for (final String forbiddenImport in forbiddenImports) {
      expect(
        source,
        isNot(contains(forbiddenImport)),
        reason: '${sourceFile.path} imports $forbiddenImport',
      );
    }
  }
}

Future<void> _expectNoSourcePatterns({
  required String file,
  required List<RegExp> forbiddenPatterns,
}) async {
  final FileSystemEntity entity =
      FileSystemEntity.typeSync(file) == FileSystemEntityType.directory
      ? Directory(file)
      : File(file);
  final List<File> sourceFiles = entity is Directory
      ? entity
            .listSync(recursive: true)
            .whereType<File>()
            .where((File sourceFile) => sourceFile.path.endsWith('.dart'))
            .toList()
      : <File>[entity as File];
  for (final File sourceFile in sourceFiles) {
    final String source = await sourceFile.readAsString();
    for (final RegExp forbiddenPattern in forbiddenPatterns) {
      expect(
        forbiddenPattern.hasMatch(source),
        isFalse,
        reason: '${sourceFile.path} matches ${forbiddenPattern.pattern}',
      );
    }
  }
}
