import 'dart:typed_data';

abstract interface class NotificationBackupFileGateway {
  Future<Uint8List?> pickArchive();

  Future<bool> saveArchive({
    required String dialogTitle,
    required String suggestedName,
    required Uint8List bytes,
  });
}

class UnavailableNotificationBackupFileGateway
    implements NotificationBackupFileGateway {
  const UnavailableNotificationBackupFileGateway();

  @override
  Future<Uint8List?> pickArchive() async => null;

  @override
  Future<bool> saveArchive({
    required String dialogTitle,
    required String suggestedName,
    required Uint8List bytes,
  }) async => false;
}
