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
    return TextFormField(
      controller: controller,
      initialValue: value,
      onChanged: onChanged as void Function(String)?,
      readOnly: disabled,
      enabled: !disabled,
      keyboardType: TextInputType.numberWithOptions(decimal: (decimals > 0)),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
        TextInputFormatter.withFunction(
          (TextEditingValue oldValue, TextEditingValue newValue) =>
              newValue.copyWith(text: newValue.text.replaceAll(',', '.')),
        ),
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
      style:
          disabled
              ? style?.copyWith(color: Theme.of(context).disabledColor)
              : style,
    );
  }

  String _getRegexString() =>
      (decimals > 0)
          ? r'^[0-9]+[,.]{0,1}[0-9]{0,' + decimals.toString() + r'}'
          : r'[0-9]';
}
