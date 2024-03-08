import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String emailAddress;
  final String password;
  final String userID;
  final String bio;
  final String nickName;
  final String profileImage;
  final DateTime onlineStatue;
  final bool isStory;
  Map<String, dynamic>? lastMessage;

  UserModel({
    required this.userName,
    required this.emailAddress,
    required this.password,
    required this.userID,
    required this.bio,
    required this.nickName,
    required this.profileImage,
    required this.onlineStatue,
    required this.isStory,
    this.lastMessage,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      userName: jsonData['userName'] ?? '',
      emailAddress: jsonData['emailAddress'] ?? '',
      password: jsonData['password'] ?? '',
      userID: jsonData['userID'] ?? '',
      bio: jsonData['bio'] ?? '',
      nickName: jsonData['nickName'] ?? '',
      profileImage: jsonData['profileImage'] ?? '',
      onlineStatue: (jsonData['onlineStatue'] ?? Timestamp.now()).toDate(),
      isStory: jsonData['isStory'] ?? false,
      lastMessage: jsonData['lastMessage'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'emailAddress': emailAddress,
      'password': password,
      'userID': userID,
      'bio': bio,
      'nickName': nickName,
      'profileImage': profileImage,
      'onlineStatue': onlineStatue,
      'isStory': isStory,
      'lastMessage': lastMessage,
    };
  }

  String formattedTime() {
    if (lastMessage != null && lastMessage!['lastMessageDateTime'] != null) {
      Timestamp timestamp = lastMessage!['lastMessageDateTime'];
      DateTime dateTime = timestamp.toDate();
      return '$dateTime';
    } else {
      return '';
    }
  }
}
