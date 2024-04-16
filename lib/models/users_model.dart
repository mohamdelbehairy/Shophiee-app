import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String emailAddress;
  final String userID;
  final String bio;
  final String nickName;
  final String dateOfBirth;
  final String gender;
  String? phoneNumber;
  final String profileImage;
  final DateTime onlineStatue;
  final bool isStory;
  Map<String, dynamic>? lastMessage;

  UserModel({
    required this.userName,
    required this.emailAddress,
    required this.userID,
    required this.bio,
    required this.nickName,
    required this.profileImage,
    required this.gender,
    this.phoneNumber,
    required this.onlineStatue,
    required this.dateOfBirth,
    required this.isStory,
    this.lastMessage,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      userName: jsonData['userName'] ?? '',
      emailAddress: jsonData['emailAddress'] ?? '',
      userID: jsonData['userID'] ?? '',
      bio: jsonData['bio'] ?? '',
      nickName: jsonData['nickName'] ?? '',
      profileImage: jsonData['profileImage'] ?? '',
      dateOfBirth: jsonData['dateOfBirth'] ?? '',
      phoneNumber: jsonData['phoneNumber'],
      gender: jsonData['gender'] ?? '',
      onlineStatue: (jsonData['onlineStatue'] ?? Timestamp.now()).toDate(),
      isStory: jsonData['isStory'] ?? false,
      lastMessage: jsonData['lastMessage'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'emailAddress': emailAddress,
      'userID': userID,
      'bio': bio,
      'nickName': nickName,
      'profileImage': profileImage,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'onlineStatue': onlineStatue,
      'isStory': isStory,
      // 'lastMessage': lastMessage,
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
