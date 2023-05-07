import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';

import 'package:waterflyiii/widgets/erroricon.dart';

final Logger log = Logger("Widgets.AutoCompleteText");

class AutoCompleteText<T extends Object> extends StatelessWidget {
  const AutoCompleteText({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.labelText,
    required this.optionsBuilder,
    this.labelIcon,
    this.displayStringForOption = defaultStringForOption,
    this.disabled = false,
    this.onSelected,
    this.onChanged,
    this.style,
    this.errorText,
    this.errorIconOnly = false,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final String labelText;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final IconData? labelIcon;
  final String Function(T) displayStringForOption;
  final bool disabled;
  final void Function(T)? onSelected;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final String? errorText;
  final bool errorIconOnly;

  @override
  Widget build(BuildContext context) {
    log.finest("build(labelText: $labelText)");
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          RawAutocomplete<T>(
        textEditingController: textController,
        focusNode: focusNode,
        onSelected: onSelected,
        displayStringForOption: displayStringForOption,
        fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                void onFieldSubmitted) =>
            TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: onChanged,
          readOnly: disabled,
          enabled: !disabled,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            icon: (labelIcon != null) ? Icon(labelIcon) : null,
            filled: disabled,
            suffixIcon: errorText != null && errorIconOnly
                ? const ErrorIcon(true)
                : null,
            errorText: errorText,
            errorStyle: errorIconOnly ? const TextStyle(fontSize: 0) : null,
          ),
          enableSuggestions: true,
          style: disabled
              ? style?.copyWith(color: Theme.of(context).disabledColor)
              : style,
        ),
        optionsViewBuilder: (BuildContext context,
                void Function(T) onOptionSelected, Iterable<T> options) =>
            Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: labelIcon == null ? 0 : 40),
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                  maxWidth:
                      constraints.biggest.width - (labelIcon == null ? 0 : 40),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final T option = options.elementAt(index);
                    return InkWell(
                      onTap: () => onOptionSelected(option),
                      child: Builder(builder: (BuildContext context) {
                        final bool highlight =
                            AutocompleteHighlightedOption.of(context) == index;
                        if (highlight) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Scrollable.ensureVisible(context, alignment: 0.5);
                          });
                        }
                        return Container(
                          color:
                              highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(displayStringForOption(option)),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        optionsBuilder: optionsBuilder,
      ),
    );
  }

  static String defaultStringForOption(dynamic option) {
    return option.toString();
  }
}
