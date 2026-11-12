import 'package:material_ui/material_ui.dart';

extension NotificationTextStyles on BuildContext {
  TextStyle? get notificationSectionTitle => Theme.of(
    this,
  ).textTheme.titleLarge?.copyWith(color: Theme.of(this).colorScheme.onSurface);

  TextStyle? get notificationSectionDescription => Theme.of(
    this,
  ).textTheme.bodyMedium?.copyWith(color: Theme.of(this).colorScheme.outline);

  TextStyle? get notificationSupportingText => Theme.of(
    this,
  ).textTheme.bodyMedium?.copyWith(color: Theme.of(this).colorScheme.outline);

  TextStyle? get notificationMetadataText => Theme.of(
    this,
  ).textTheme.bodySmall?.copyWith(color: Theme.of(this).colorScheme.outline);

  TextStyle? get notificationValueTypeText => Theme.of(
    this,
  ).textTheme.bodySmall?.copyWith(color: Theme.of(this).colorScheme.outline);

  TextStyle? get notificationEmptyText =>
      Theme.of(this).textTheme.bodyMedium?.copyWith(
        color: Theme.of(this).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      );

  Color get notificationSupportingColor => Theme.of(this).colorScheme.outline;
}
