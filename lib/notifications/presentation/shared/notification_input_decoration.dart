import 'package:material_ui/material_ui.dart';

const BorderRadius notificationControlRadius = BorderRadius.all(
  Radius.circular(8),
);

BorderSide notificationControlBorder(BuildContext context) =>
    BorderSide(color: Theme.of(context).colorScheme.outlineVariant);

BoxDecoration notificationControlDecoration(BuildContext context) =>
    BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: notificationControlRadius,
      border: Border.fromBorderSide(notificationControlBorder(context)),
    );

RoundedRectangleBorder notificationControlShape(BuildContext context) =>
    RoundedRectangleBorder(
      borderRadius: notificationControlRadius,
      side: notificationControlBorder(context),
    );

OutlineInputBorder notificationInputBorder(
  BuildContext context, {
  bool focused = false,
}) => OutlineInputBorder(
  borderRadius: notificationControlRadius,
  borderSide: focused
      ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
      : notificationControlBorder(context),
);

InputDecoration notificationInputDecoration(
  BuildContext context, {
  String? labelText,
  String? hintText,
  String? errorText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool alignLabelWithHint = false,
  EdgeInsetsGeometry? contentPadding,
}) => InputDecoration(
  labelText: labelText,
  hintText: hintText,
  errorText: errorText,
  prefixIcon: prefixIcon,
  suffixIcon: suffixIcon,
  alignLabelWithHint: alignLabelWithHint,
  contentPadding: contentPadding,
  filled: true,
  fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
  border: notificationInputBorder(context),
  enabledBorder: notificationInputBorder(context),
  focusedBorder: notificationInputBorder(context, focused: true),
);
