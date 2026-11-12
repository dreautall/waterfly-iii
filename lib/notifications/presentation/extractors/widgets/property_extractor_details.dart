import 'package:material_ui/material_ui.dart';
import 'package:waterflyiii/generated/l10n/app_localizations.dart';
import 'package:waterflyiii/notifications/domain/definitions/notification_sample.dart';
import 'package:waterflyiii/notifications/domain/extractors/reg_exp_definition.dart';
import 'package:waterflyiii/notifications/presentation/shared/definition_detail_card.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_text_styles.dart';
import 'package:waterflyiii/notifications/presentation/shared/notification_date_time_formatter.dart';

class PropertyExtractorDetails extends StatelessWidget {
  const PropertyExtractorDetails({
    super.key,
    required this.type,
    required this.sample,
  });

  final PredefinedRegExpDefinition type;
  final NotificationSample sample;

  @override
  Widget build(BuildContext context) {
    final List<_PropertyValue> values = _values(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).notificationsExtractorDescription,
          style: context.notificationSectionTitle,
        ),
        const SizedBox(height: 4),
        Text(
          _description(context),
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            const Icon(Icons.manage_search_outlined),
            const SizedBox(width: 8),
            Text(
              S.of(context).notificationsExtractorMatches,
              style: context.notificationSectionTitle,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          S.of(context).notificationsExtractorPropertyMatchesDescription,
          style: context.notificationSectionDescription,
        ),
        const SizedBox(height: 12),
        ...values.map(
          (_PropertyValue value) => Padding(
            padding: EdgeInsets.only(bottom: values.length == 1 ? 0 : 8),
            child: DefinitionDetailCard(
              leading: Icon(value.icon),
              title: Text(value.label),
              subtitle: Text(
                value.value,
                style: context.notificationSupportingText,
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  value.valueType,
                  style: context.notificationValueTypeText,
                ),
              ),
              backgroundColor:
                  Theme.of(context).cardTheme.color ??
                  Theme.of(context).colorScheme.surfaceContainerLow,
              centerAffordances: true,
            ),
          ),
        ),
      ],
    );
  }

  String _description(BuildContext context) => switch (type) {
    PredefinedRegExpDefinition.notificationTitle =>
      S.of(context).notificationsExtractorUsesTitle,
    PredefinedRegExpDefinition.notificationMessage =>
      S.of(context).notificationsExtractorUsesMessage,
    PredefinedRegExpDefinition.notificationDate =>
      S.of(context).notificationsExtractorUsesReceivedTime,
    _ => '',
  };

  List<_PropertyValue> _values(BuildContext context) => switch (type) {
    PredefinedRegExpDefinition.notificationTitle => <_PropertyValue>[
      _PropertyValue(
        S.of(context).notificationsExtractorNotificationTitle,
        sample.title,
        S.of(context).notificationsValueTypeText,
        Icons.title_outlined,
      ),
    ],
    PredefinedRegExpDefinition.notificationMessage => <_PropertyValue>[
      _PropertyValue(
        S.of(context).notificationsExtractorNotificationMessage,
        sample.body,
        S.of(context).notificationsValueTypeText,
        Icons.message_outlined,
      ),
    ],
    PredefinedRegExpDefinition.notificationDate => <_PropertyValue>[
      _PropertyValue(
        S.of(context).notificationsValueTypeDate,
        formatNotificationDate(context, sample.receivedAt),
        S.of(context).notificationsValueTypeDate,
        Icons.calendar_today_outlined,
      ),
      _PropertyValue(
        S.of(context).notificationsValueTypeTime,
        formatNotificationTime(
          context,
          TimeOfDay.fromDateTime(sample.receivedAt),
        ),
        S.of(context).notificationsValueTypeTime,
        Icons.schedule_outlined,
      ),
    ],
    _ => const <_PropertyValue>[],
  };
}

class _PropertyValue {
  const _PropertyValue(this.label, this.value, this.valueType, this.icon);

  final String label;
  final String value;
  final String valueType;
  final IconData icon;
}
