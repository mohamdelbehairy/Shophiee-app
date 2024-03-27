import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MediaFilesModel {
  final String messageID;
  final String senderID;
  final DateTime dateTime;
  String? messageImage;
  String? messageVideo;
  String? messageText;
  String? messageFile;
  String? messageFileName;
  double? messageFileSize;
  String? messageFileType;

  MediaFilesModel(
      {required this.messageID,
      required this.senderID,
      required this.dateTime,
      this.messageImage,
      this.messageVideo,
      this.messageText,
      this.messageFile,
      this.messageFileName,
      this.messageFileSize,
      this.messageFileType});

  factory MediaFilesModel.fromJson(jsonData) {
    return MediaFilesModel(
        messageID: jsonData['messageID'],
        senderID: jsonData['senderID'],
        dateTime: (jsonData['dateTime'] as Timestamp).toDate(),
        messageImage: jsonData['messageImage'],
        messageVideo: jsonData['messageVideo'],
        messageText: jsonData['messageText'],
        messageFile: jsonData['messageFile'],
        messageFileName: jsonData['messageFileName'],
        messageFileSize: jsonData['messageFileSize'],
        messageFileType: jsonData['messageFileType']);
  }

  Map<String, dynamic> toMap() {
    return {
      'messageID': messageID,
      'senderID': senderID,
      'dateTime': dateTime,
      'messageImage': messageImage,
      'messageVideo': messageVideo,
      'messageText': messageText,
      'messageFile': messageFile,
      'messageFileName': messageFileName,
      'messageFileSize': messageFileSize,
      'messageFileType': messageFileType
    };
  }

  String showGroupMediaTime() {
    return DateFormat('dd/MM/yy').format(dateTime);
  }

  String showFielsTime() {
    return DateFormat('dd/MM/yy').format(dateTime);
  }
}
