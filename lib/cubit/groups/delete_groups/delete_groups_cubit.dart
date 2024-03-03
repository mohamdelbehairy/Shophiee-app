import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'delete_groups_state.dart';

class DeleteGroupsCubit extends Cubit<DeleteGroupsState> {
  DeleteGroupsCubit() : super(DeleteGroupsInitial());

  Future<void> deleteAndLeaveGroupOwner({required String groupID}) async {
    emit(DeleteGroupsLoading());
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .delete();
      emit(DeleteGroupsSuccessOwner());
    } catch (e) {
      debugPrint('error from delete group chat method: ${e.toString()}');
      emit(DeleteGroupsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> leaveGroupMember({required String groupID}) async {
    emit(DeleteGroupsLoading());
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .update({
        'usersID':
            FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
      emit(LeaveGroupsSuccessMember());
    } catch (e) {
      debugPrint('error from leave group chat method: ${e.toString()}');
      emit(DeleteGroupsFailure(errorMessage: e.toString()));
    }
  }
}
