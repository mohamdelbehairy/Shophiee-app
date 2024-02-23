import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CreateGroupsCubit extends Cubit<CreateGroupsState> {
  CreateGroupsCubit() : super(CreateGroupsInitial());

  Future<void> createGroups({required List<String> usersID}) async {
    try {
      usersID.add(FirebaseAuth.instance.currentUser!.uid);
      GroupModel groupModel = GroupModel.fromJson({
        'groupID': Uuid().v1(),
        'createUserID': FirebaseAuth.instance.currentUser!.uid,
        'usersID': usersID,
        'groupCreateAt': Timestamp.now()
      });


      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupModel.groupID)
          .set(groupModel.toMap());
      addGroupIDToUser(groupID: groupModel.groupID, usersID: usersID);
      emit(CreateGroupsSuccess());
    } catch (e) {
      debugPrint('error from create groups method: ${e.toString()}');
      emit(CreateGroupsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addGroupIDToUser(
      {required String groupID, required List<String> usersID}) async {
    try {
      for (var userID in usersID) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('groups')
            .doc(groupID)
            .set({'groupID': groupID});
      }
    } catch (e) {
      debugPrint('error from add group id to user: ${e.toString()}');
    }
  }

  // List<GroupModel> groupsID = [];
  void displayGroupIfUserHasAccess() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('groups')
          .snapshots()
          .listen((event) {
            if(event.docs.isNotEmpty) {

            }
        // groupsID.clear();
        // for (var element in event.docs) {
        //   String groupID = element.data()['groupID'];
        //   print('element:${element.data()['groupID']}');
        // }
        // print('event: ${event.size}');
        // print('event: ${event.docs.length}');
        // getGroups();
        // emit(GetGroupsIDSuccess());
      });
    } catch (e) {
      debugPrint('error from displayGroupIfUserHasAccess: ${e.toString()}');
    }
  }

  List<GroupModel> userGroupsList = [];
  void getGroups() {
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .snapshots()
          .listen((snapshot) {
        userGroupsList.clear();
        for (var group in snapshot.docs) {
          userGroupsList.add(GroupModel.fromJson(group.data()));
        }
        print('userGroupsList: ${userGroupsList.length}');
        print('userGroupsList: ${userGroupsList.toList()}');
        emit(GetGroupSuccess());
      });
    } catch (e) {
      debugPrint('error fetching user groups: ${e.toString()}');
      emit(GetGroupFailure(errorMessage: e.toString()));
    }
  }
}
