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
    };
  }
}
