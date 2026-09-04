import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/swagger_fireflyiii_api/firefly_iii.swagger.dart';

class TransactionColors extends ThemeExtension<TransactionColors> {
  final Color? positiveColor;
  final Color? negativeColor;
  final Color? transferColor;
  final Color? neutralColor;

  const TransactionColors({
    required this.positiveColor,
    required this.negativeColor,
    required this.transferColor,
    required this.neutralColor,
  });

  @override
  TransactionColors copyWith({
    Color? positiveColor,
    Color? negativeColor,
    Color? transferColor,
    Color? neutralColor,
  }) {
    return TransactionColors(
      negativeColor: negativeColor ?? this.negativeColor,
      positiveColor: positiveColor ?? this.positiveColor,
      transferColor: transferColor ?? this.transferColor,
      neutralColor: neutralColor ?? this.neutralColor,
    );
  }

  @override
  TransactionColors lerp(ThemeExtension<TransactionColors>? other, double t) {
    if (other is! TransactionColors) return this;
    return TransactionColors(
      positiveColor: Color.lerp(positiveColor, other.positiveColor, t),
      negativeColor: Color.lerp(negativeColor, other.negativeColor, t),
      transferColor: Color.lerp(transferColor, other.transferColor, t),
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t),
    );
  }
}

extension ColorHelper on BuildContext {
  Color transactionColor(TransactionTypeProperty type) {
    final TransactionColors theme = Theme.of(
      this,
    ).extension<TransactionColors>()!;
    switch (type) {
      case TransactionTypeProperty.deposit:
        return theme.positiveColor!;
      case TransactionTypeProperty.withdrawal:
        return theme.negativeColor!;
      case TransactionTypeProperty.transfer:
        return theme.transferColor!;
      default:
        return theme.neutralColor!;
    }
  }
}
