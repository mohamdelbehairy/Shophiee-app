import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MediaFielsModel {
  final String messageID;
  final String senderID;
  final DateTime dateTime;
  String? messageImage;
  String? messageVideo;
  String? messageText;

  MediaFielsModel(
      {required this.messageID,
      required this.senderID,
      required this.dateTime,
      this.messageImage,
      this.messageVideo,
      this.messageText});

  factory MediaFielsModel.fromJson(jsonData) {
    return MediaFielsModel(
        messageID: jsonData['messageID'],
        senderID: jsonData['senderID'],
        dateTime: (jsonData['dateTime'] as Timestamp).toDate(),
        messageImage: jsonData['messageImage'],
        messageVideo: jsonData['messageVideo'],
        messageText: jsonData['messageText']);
  }

  Map<String, dynamic> toMap() {
    return {
      'messageID': messageID,
      'senderID': senderID,
      'dateTime': dateTime,
      'messageImage': messageImage,
      'messageVideo': messageVideo,
      'messageText': messageText
    };
  }


  String showChatImageTime() {
    return DateFormat('dd/MM/yy, HH:mm').format(dateTime);
  }
}
