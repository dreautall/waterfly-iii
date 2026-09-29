import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_rename_field.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_input_decoration.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';

enum _RegExpSyntaxKind {
  plain,
  escape,
  group,
  characterClass,
  quantifier,
  operator,
}

class _RegExpSyntaxToken {
  const _RegExpSyntaxToken(this.text, this.kind);

  final String text;
  final _RegExpSyntaxKind kind;
}

class RegExpTextEditingController extends TextEditingController {
  RegExpTextEditingController({super.text});

  static final RegExp _bracedQuantifier = RegExp(r'^\{\d+(?:,\d*)?\}[?+]?');

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      style: style,
      children: _tokenize(text).map((_RegExpSyntaxToken token) {
        if (token.kind == _RegExpSyntaxKind.plain) {
          return TextSpan(text: token.text);
        }
        return TextSpan(
          text: token.text,
          style: TextStyle(
            color: _syntaxColor(context, token.kind),
            fontWeight: FontWeight.w600,
          ),
        );
      }).toList(),
    );
  }

  List<_RegExpSyntaxToken> _tokenize(String source) {
    final List<_RegExpSyntaxToken> tokens = <_RegExpSyntaxToken>[];
    int index = 0;
    while (index < source.length) {
      final String character = source[index];
      if (character == r'\') {
        final int end = index + 1 < source.length ? index + 2 : index + 1;
        _appendToken(
          tokens,
          source.substring(index, end),
          _RegExpSyntaxKind.escape,
        );
        index = end;
        continue;
      }
      if (character == '[') {
        final int end = _characterClassEnd(source, index);
        _appendToken(
          tokens,
          source.substring(index, end),
          _RegExpSyntaxKind.characterClass,
        );
        index = end;
        continue;
      }
      if (character == '(') {
        final int end = _groupOpeningEnd(source, index);
        _appendToken(
          tokens,
          source.substring(index, end),
          _RegExpSyntaxKind.group,
        );
        index = end;
        continue;
      }
      if (character == ')') {
        _appendToken(tokens, character, _RegExpSyntaxKind.group);
        index++;
        continue;
      }
      if (character == '{') {
        final RegExpMatch? quantifier = _bracedQuantifier.firstMatch(
          source.substring(index),
        );
        if (quantifier != null) {
          final String value = quantifier.group(0)!;
          _appendToken(tokens, value, _RegExpSyntaxKind.quantifier);
          index += value.length;
          continue;
        }
      }
      if (character == '?' || character == '*' || character == '+') {
        int end = index + 1;
        if (end < source.length && (source[end] == '?' || source[end] == '+')) {
          end++;
        }
        _appendToken(
          tokens,
          source.substring(index, end),
          _RegExpSyntaxKind.quantifier,
        );
        index = end;
        continue;
      }
      if (character == '|' ||
          character == '^' ||
          character == r'$' ||
          character == '.') {
        _appendToken(tokens, character, _RegExpSyntaxKind.operator);
        index++;
        continue;
      }
      _appendToken(tokens, character, _RegExpSyntaxKind.plain);
      index++;
    }
    return tokens;
  }

  int _characterClassEnd(String source, int start) {
    int index = start + 1;
    while (index < source.length) {
      if (source[index] == r'\') {
        index += index + 1 < source.length ? 2 : 1;
        continue;
      }
      if (source[index] == ']') return index + 1;
      index++;
    }
    return source.length;
  }

  int _groupOpeningEnd(String source, int start) {
    if (start + 1 >= source.length || source[start + 1] != '?') {
      return start + 1;
    }
    final int markerIndex = start + 2;
    if (markerIndex >= source.length) return source.length;
    final String marker = source[markerIndex];
    if (marker == '<') {
      if (markerIndex + 1 < source.length &&
          (source[markerIndex + 1] == '=' || source[markerIndex + 1] == '!')) {
        return markerIndex + 2;
      }
      final int nameEnd = source.indexOf('>', markerIndex + 1);
      return nameEnd < 0 ? source.length : nameEnd + 1;
    }
    if (marker == ':' || marker == '=' || marker == '!' || marker == '>') {
      return markerIndex + 1;
    }
    int index = markerIndex;
    while (index < source.length) {
      final int codeUnit = source.codeUnitAt(index);
      final bool isLetter =
          (codeUnit >= 65 && codeUnit <= 90) ||
          (codeUnit >= 97 && codeUnit <= 122);
      if (!isLetter && source[index] != '-') break;
      index++;
    }
    if (index < source.length &&
        (source[index] == ':' || source[index] == ')')) {
      return index + 1;
    }
    return markerIndex;
  }

  void _appendToken(
    List<_RegExpSyntaxToken> tokens,
    String value,
    _RegExpSyntaxKind kind,
  ) {
    if (value.isEmpty) return;
    if (kind == _RegExpSyntaxKind.plain &&
        tokens.isNotEmpty &&
        tokens.last.kind == kind) {
      final _RegExpSyntaxToken previous = tokens.removeLast();
      tokens.add(_RegExpSyntaxToken('${previous.text}$value', kind));
      return;
    }
    tokens.add(_RegExpSyntaxToken(value, kind));
  }

  Color _syntaxColor(BuildContext context, _RegExpSyntaxKind kind) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return switch (kind) {
      _RegExpSyntaxKind.escape =>
        isDark ? const Color(0xFF80CBC4) : const Color(0xFF00695C),
      _RegExpSyntaxKind.group =>
        isDark ? const Color(0xFFFFCC80) : const Color(0xFFE65100),
      _RegExpSyntaxKind.characterClass =>
        isDark ? const Color(0xFFB39DDB) : const Color(0xFF4527A0),
      _RegExpSyntaxKind.quantifier =>
        isDark ? const Color(0xFFF48FB1) : const Color(0xFFAD1457),
      _RegExpSyntaxKind.operator =>
        isDark ? const Color(0xFF90CAF9) : const Color(0xFF1565C0),
      _RegExpSyntaxKind.plain => Theme.of(context).colorScheme.onSurface,
    };
  }
}

class RenameExtractorDialog extends StatefulWidget {
  const RenameExtractorDialog({super.key, required this.name});

  final String name;

  @override
  State<RenameExtractorDialog> createState() => _RenameExtractorDialogState();
}

class ExtractorDetailsUpdate {
  const ExtractorDetailsUpdate({required this.name, required this.description});

  final String name;
  final String description;
}

class EditExtractorDetailsDialog extends StatefulWidget {
  const EditExtractorDetailsDialog({
    super.key,
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  @override
  State<EditExtractorDetailsDialog> createState() =>
      _EditExtractorDetailsDialogState();
}

class _EditExtractorDetailsDialogState
    extends State<EditExtractorDetailsDialog> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.name,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.description);

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.of(context).notificationsExtractorEditDetailsTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsExtractorEditDetailsDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 16),
        NotificationRenameField(
          controller: _nameController,
          label: S.of(context).notificationsExtractorName,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descriptionController,
          minLines: 2,
          maxLines: 4,
          textCapitalization: TextCapitalization.sentences,
          decoration: notificationInputDecoration(
            context,
            labelText: S.of(context).notificationsDescriptionOptional,
            alignLabelWithHint: true,
          ),
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      ),
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: _nameController,
        builder: (BuildContext context, TextEditingValue value, Widget? _) =>
            FilledButton(
              onPressed: value.text.trim().isEmpty
                  ? null
                  : () => Navigator.of(context, rootNavigator: true)
                        .pop<ExtractorDetailsUpdate>(
                          ExtractorDetailsUpdate(
                            name: _nameController.text.trim(),
                            description: _descriptionController.text.trim(),
                          ),
                        ),
              child: Text(S.of(context).notificationsExtractorSave),
            ),
      ),
    ],
  );
}

class _RenameExtractorDialogState extends State<RenameExtractorDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.name,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(S.of(context).notificationsExtractorRenameTitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsExtractorRenameDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 16),
        NotificationRenameField(
          controller: _controller,
          label: S.of(context).notificationsExtractorName,
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      ),
      FilledButton(
        onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
        child: Text(S.of(context).notificationsExtractorSave),
      ),
    ],
  );
}
