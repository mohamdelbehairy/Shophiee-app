import 'package:app/models/message_model.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveSound({required MessageModel messages}) async {
  await Permission.storage.request();

  FileDownloader.downloadFile(
      url: messages.messageSound!.trim(),
      name: messages.messageSoundName,
      notificationType: NotificationType.all,
      onDownloadCompleted: (value) {
        print('path $value');
      });
}
