import 'package:waterflyiii/notifications/domain/planning/transaction_creation_mode.dart';

enum NotificationRuleProcessingMode {
  inherit,
  prompt,
  automatic,
  ignore;

  bool get ignoresNotification => this == ignore;

  TransactionCreationMode resolve(TransactionCreationMode applicationMode) =>
      switch (this) {
        inherit => applicationMode,
        prompt => TransactionCreationMode.prompt,
        automatic => TransactionCreationMode.automatic,
        ignore => applicationMode,
      };
}
