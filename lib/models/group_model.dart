import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String groupID;
  final String groupName;
  String? groupImage;
  final String groupOwnerID;
  List<String> usersID;
  List<String> adminsID;
  final DateTime groupCreateAt;

  GroupModel(
      {required this.groupID,
      required this.groupName,
      this.groupImage,
      required this.groupOwnerID,
      this.usersID = const [],
      this.adminsID = const [],
      required this.groupCreateAt});

  factory GroupModel.fromJson(jsonData) {
    return GroupModel(
        groupID: jsonData['groupID'],
        groupName: jsonData['groupName'],
        groupImage: jsonData['groupImage'],
        groupOwnerID: jsonData['groupOwnerID'],
        usersID: (jsonData['usersID'] as List<dynamic>)
            .map((userId) => userId.toString())
            .toList(),
        adminsID: (jsonData['adminsID'] as List<dynamic>)
            .map((userId) => userId.toString())
            .toList(),
        groupCreateAt: (jsonData['groupCreateAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'groupID': groupID,
      'groupName': groupName,
      'groupImage': groupImage,
      'groupOwnerID': groupOwnerID,
      'usersID': usersID,
      'adminsID': adminsID,
      'groupCreateAt': groupCreateAt
    };
  }
}
