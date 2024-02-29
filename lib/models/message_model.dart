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
  final String? messageFile;
  final String? messageFileName;
  final String? phoneContactNumber;
  final String? phoneContactName;
  final String? messageVideo;
  final String? messageImageFile;
  final String? messageVideoFile;
  final String? messageFileFile;
  List<dynamic> groupChatUsersIDSeen;
  String? replayTextMessage;
  String? replayImageMessage;
  String? replayFileMessage;
  String? replayContactMessage;
  String? userSenderID;

  MessageModel(
      {required this.senderID,
      required this.receiverID,
      required this.messageID,
      required this.messageText,
      required this.messageDateTime,
      required this.isSeen,
      this.messageImage,
      this.messageFile,
      this.messageFileName,
      this.phoneContactNumber,
      this.phoneContactName,
      this.messageVideo,
      this.messageImageFile,
      this.messageVideoFile,
      this.messageFileFile,
      this.groupChatUsersIDSeen = const [],
      this.replayTextMessage,
      this.replayImageMessage,
      this.replayFileMessage,
      this.replayContactMessage,
      this.userSenderID});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        senderID: jsonData['senderID'],
        receiverID: jsonData['receiverID'],
        messageID: jsonData['messageID'],
        messageText: jsonData['messageText'],
        messageDateTime: (jsonData['messageDateTime'] as Timestamp).toDate(),
        isSeen: jsonData['isSeen'],
        messageImage: jsonData['messageImage'],
        messageFile: jsonData['messageFile'],
        messageFileName: jsonData['messageFileName'],
        phoneContactNumber: jsonData['phoneContactNumber'],
        phoneContactName: jsonData['phoneContactName'],
        messageVideo: jsonData['messageVideo'],
        messageImageFile: jsonData['messageImageFile'],
        messageVideoFile: jsonData['messageVideoFile'],
        messageFileFile: jsonData['messageFileFile'],
        groupChatUsersIDSeen: jsonData['groupChatUsersIDSeen'],
        replayTextMessage: jsonData['replayTextMessage'],
        replayImageMessage: jsonData['replayImageMessage'],
        replayFileMessage: jsonData['replayFileMessage'],
        replayContactMessage: jsonData['replayContactMessage'],
        userSenderID: jsonData['userSenderID']);
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
      'messageFile': messageFile,
      'messageFileName': messageFileName,
      'phoneContactNumber': phoneContactNumber,
      'phoneContactName': phoneContactName,
      'messageVideo': messageVideo,
      'messageImageFile': messageImageFile,
      'messageVideoFile': messageVideoFile,
      'messageFileFile': messageFileFile,
      'groupChatUsersIDSeen': groupChatUsersIDSeen,
      'replayTextMessage': replayTextMessage,
      'replayImageMessage': replayImageMessage,
      'replayFileMessage': replayFileMessage,
      'replayContactMessage': replayContactMessage,
      'userSenderID':userSenderID
    };
  }

  String formattedTime() {
    return DateFormat('HH:mm ').format(messageDateTime);
  }

  String showChatImageTime() {
    return DateFormat('dd/MM/yy, HH:mm').format(messageDateTime);
  }
}
