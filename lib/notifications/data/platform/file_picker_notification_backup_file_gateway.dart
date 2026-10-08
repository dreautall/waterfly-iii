import 'dart:typed_data';

import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:waterflyiii/notifications/application/settings/notification_backup_file_gateway.dart';

class FilePickerNotificationBackupFileGateway
    implements NotificationBackupFileGateway {
  const FilePickerNotificationBackupFileGateway();

  @override
  Future<Uint8List?> pickArchive() async {
    final file_picker.PlatformFile? file =
        await file_picker.FilePicker.pickFile(
          type: file_picker.FileType.custom,
          allowedExtensions: <String>['zip'],
        );
    return file?.readAsBytes();
  }

  @override
  Future<bool> saveArchive({
    required String dialogTitle,
    required String suggestedName,
    required Uint8List bytes,
  }) async {
    final Uri? uri = await file_picker.FilePicker.saveFile(
      dialogTitle: dialogTitle,
      fileName: suggestedName,
      type: file_picker.FileType.custom,
      allowedExtensions: <String>['zip'],
      mimeType: 'application/zip',
      bytes: bytes,
    );
    return uri != null;
  }
}
