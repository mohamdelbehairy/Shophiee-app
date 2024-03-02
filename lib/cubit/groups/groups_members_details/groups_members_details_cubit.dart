import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'groups_members_details_state.dart';

class GroupsMembersDetailsCubit extends Cubit<GroupsMembersDetailsState> {
  GroupsMembersDetailsCubit() : super(GroupsMembersDetailsInitial());

  Future<void> removeGroupMember(
      {required String groupID, required String memberID}) async {
    emit(RemoveMemebrLoading());
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .update({
        'usersID': FieldValue.arrayRemove([memberID])
      });
      emit(RemoveMemberSuccess());
    } catch (e) {
      debugPrint('error from remove group member method: ${e.toString()}');
      emit(RemoveMemberFailure(errorMessage: e.toString()));
    }
  }
}
