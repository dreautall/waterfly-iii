import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/notifications/presentation/extractors/widgets/extractor_editor_components.dart';

void main() {
  testWidgets('highlights common regular expression syntax', (
    WidgetTester tester,
  ) async {
    final RegExpTextEditingController controller = RegExpTextEditingController(
      text: r'^(?<amount>\d+(?:\.\d{2})?)\s*(?:CAD|USD)$',
    );
    late TextSpan span;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            span = controller.buildTextSpan(
              context: context,
              style: DefaultTextStyle.of(context).style,
              withComposing: false,
            );
            return const SizedBox();
          },
        ),
      ),
    );

    final List<TextSpan> tokens = span.children!
        .cast<TextSpan>()
        .where((TextSpan child) => child.style != null)
        .toList();

    expect(tokens.map((TextSpan token) => token.text), <String>[
      '^',
      '(?<amount>',
      r'\d',
      '+',
      '(?:',
      r'\.',
      r'\d',
      '{2}',
      ')',
      '?',
      ')',
      r'\s',
      '*',
      '(?:',
      '|',
      ')',
      r'$',
    ]);
    expect(tokens[1].style!.color, const Color(0xFFE65100));
    expect(tokens[2].style!.color, const Color(0xFF00695C));
    expect(tokens[4].style!.color, const Color(0xFFE65100));
    expect(tokens[8].style!.color, const Color(0xFFE65100));
    expect(tokens[10].style!.color, const Color(0xFFE65100));
    expect(tokens[15].style!.color, const Color(0xFFE65100));
    expect(tokens[13].style!.color, const Color(0xFFE65100));
    expect(tokens[14].style!.color, const Color(0xFF1565C0));
    expect(tokens[1].style!.fontWeight, FontWeight.w600);
  });

  testWidgets('uses high-contrast syntax colors in dark mode', (
    WidgetTester tester,
  ) async {
    final RegExpTextEditingController controller = RegExpTextEditingController(
      text: r'(?<amount>\d+)',
    );
    late TextSpan span;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: Builder(
          builder: (BuildContext context) {
            span = controller.buildTextSpan(
              context: context,
              style: DefaultTextStyle.of(context).style,
              withComposing: false,
            );
            return const SizedBox();
          },
        ),
      ),
    );

    final List<TextSpan> tokens = span.children!
        .cast<TextSpan>()
        .where((TextSpan child) => child.style != null)
        .toList();

    expect(tokens[0].style!.color, const Color(0xFFFFCC80));
    expect(tokens[1].style!.color, const Color(0xFF80CBC4));
    expect(tokens[2].style!.color, const Color(0xFFF48FB1));
    expect(tokens[3].style!.color, const Color(0xFFFFCC80));
  });

  testWidgets('keeps escaped delimiters inside their syntax token', (
    WidgetTester tester,
  ) async {
    final RegExpTextEditingController controller = RegExpTextEditingController(
      text: r'\(\)[a\]()]++',
    );
    late TextSpan span;

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            span = controller.buildTextSpan(
              context: context,
              style: DefaultTextStyle.of(context).style,
              withComposing: false,
            );
            return const SizedBox();
          },
        ),
      ),
    );

    final List<TextSpan> tokens = span.children!
        .cast<TextSpan>()
        .where((TextSpan child) => child.style != null)
        .toList();

    expect(tokens.map((TextSpan token) => token.text), <String>[
      r'\(',
      r'\)',
      r'[a\]()]',
      '++',
    ]);
    expect(tokens[0].style!.color, const Color(0xFF00695C));
    expect(tokens[1].style!.color, const Color(0xFF00695C));
    expect(tokens[2].style!.color, const Color(0xFF4527A0));
    expect(tokens[3].style!.color, const Color(0xFFAD1457));
  });
}
