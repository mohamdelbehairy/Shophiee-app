import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String groupID;
  final String groupName;
  String? groupImage;
  final String createUserID;
  List<String> usersID;
  final DateTime groupCreateAt;

  GroupModel(
      {required this.groupID,
      required this.groupName,
      this.groupImage,
      required this.createUserID,
      this.usersID = const [],
      required this.groupCreateAt});

  factory GroupModel.fromJson(jsonData) {
    return GroupModel(
        groupID: jsonData['groupID'],
        groupName: jsonData['groupName'],
        groupImage: jsonData['groupImage'],
        createUserID: jsonData['createUserID'],
        usersID: (jsonData['usersID'] as List<dynamic>)
            .map((userId) => userId.toString())
            .toList(),
        groupCreateAt: (jsonData['groupCreateAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'groupID': groupID,
      'groupName': groupName,
      'groupImage':groupImage,
      'createUserID': createUserID,
      'usersID': usersID,
      'groupCreateAt': groupCreateAt
    };
  }
}
