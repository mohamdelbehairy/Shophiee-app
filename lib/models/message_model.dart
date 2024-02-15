import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessageModel {
  final String senderID;
  final String receiverID;
  final String messageID;
  final String messageText;
  final DateTime messageDateTime;
  final bool isSeen;
  final String? messageImage;

  MessageModel(
      {required this.senderID,
      required this.receiverID,
      required this.messageID,
      required this.messageText,
      required this.messageDateTime,
      required this.isSeen,
      this.messageImage});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      senderID: jsonData['senderID'],
      receiverID: jsonData['receiverID'],
      messageID: jsonData['messageID'],
      messageText: jsonData['messageText'],
      messageDateTime: (jsonData['messageDateTime'] as Timestamp).toDate(),
      isSeen: jsonData['isSeen'],
      messageImage: jsonData['messageImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'messageID': messageID,
      'messageText': messageText,
      'messageDateTime': messageDateTime,
      'isSeen': isSeen,
      'messageImage': messageImage,
    };
  }

  String formattedTime() {
    return DateFormat('HH:mm ').format(messageDateTime);
  }

  String showChatImageTime() {
    return DateFormat('dd/MM/yy, HH:mm').format(messageDateTime);
  }
}
