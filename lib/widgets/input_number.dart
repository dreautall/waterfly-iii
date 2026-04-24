import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    this.label,
    this.controller,
    this.value,
    this.onChanged,
    this.error,
    this.icon,
    this.hintText,
    this.prefixText,
    this.decimals = 0,
    this.disabled = false,
    this.style,
  });

  final TextEditingController? controller;
  final String? value;
  final String? label;
  final Function? onChanged;
  final String? error;
  final Widget? icon;
  final String? hintText;
  final String? prefixText;
  final int decimals;
  final bool disabled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (bool hasFocus) {
        if (hasFocus || controller == null) {
          return;
        }
        final double result = _evaluateExpression(controller!.text);
        controller!.text = result.toStringAsFixed(decimals);
      },
      child: TextFormField(
        controller: controller,
        initialValue: value,
        onChanged: onChanged as void Function(String)?,
        readOnly: disabled,
        enabled: !disabled,
        keyboardType: .numberWithOptions(
          decimal: (decimals > 0),
          signed: false,
        ),
        inputFormatters: <TextInputFormatter>[
          .withFunction(
            (TextEditingValue oldValue, TextEditingValue newValue) =>
                newValue.copyWith(text: newValue.text.replaceAll(',', '.')),
          ),
          .withFunction((TextEditingValue oldValue, TextEditingValue newValue) {
            if (newValue.composing != TextRange.empty) {
              return newValue;
            }

            // Check for operators in newValue
            final int opCount = RegExp(
              r'[+\-*/]',
            ).allMatches(newValue.text).length;

            // no operators --> normal number validation
            if (opCount == 0) {
              if (newValue.text.isNotEmpty &&
                  !_getRegex().hasMatch(newValue.text)) {
                return oldValue;
              }

              return newValue;
            }

            if (opCount > 1) {
              // Only when last operator was inserted at end
              if (newValue.text.startsWith(oldValue.text)) {
                final double result = _evaluateExpression(oldValue.text);

                final String newText =
                    result.toStringAsFixed(decimals) +
                    newValue.text.substring(oldValue.text.length);
                return newValue.copyWith(
                  text: newText,
                  selection: .collapsed(offset: newText.length),
                );
              }
            }

            // Split number by operators, validate each number separately
            final List<String> numbers = newValue.text.split(
              RegExp(r'[+\-*/]'),
            );
            for (int i = 0; i < numbers.length; i++) {
              // As calculations like "0.005 * 1234" should be allowed, just check
              // if it's a valid number, regardless of decimals
              if (numbers[i].isNotEmpty &&
                  !RegExp(r'^[0-9]+[,.]?[0-9]*$').hasMatch(numbers[i])) {
                return oldValue;
              }
            }

            return newValue;
          }),
        ],
        decoration: InputDecoration(
          label: (label != null) ? Text(label!) : null,
          hintText: hintText,
          errorText: error,
          icon: icon,
          border: const OutlineInputBorder(),
          prefixText: prefixText,
          filled: disabled,
        ),
        style: disabled
            ? style?.copyWith(color: Theme.of(context).disabledColor)
            : style,
      ),
    );
  }

  RegExp _getRegex() => (decimals > 0)
      ? RegExp(r'^[0-9]+[,.]{0,1}[0-9]{0,' + decimals.toString() + r'}$')
      : RegExp(r'^[0-9]+$');

  double _evaluateExpression(String expression) {
    final Expression? exp = Expression.tryParse(expression);
    if (exp == null) {
      return 0;
    }
    final dynamic result = const ExpressionEvaluator().eval(
      exp,
      <String, dynamic>{},
    );
    final double resultDouble = result?.toDouble() ?? 0;
    return resultDouble < 0 ? 0 : resultDouble;
  }
}
