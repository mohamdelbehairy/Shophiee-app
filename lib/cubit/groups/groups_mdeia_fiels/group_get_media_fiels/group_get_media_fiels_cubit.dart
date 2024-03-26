import 'package:app/models/media_fiels_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
part 'group_get_media_fiels_state.dart';

class GroupGetMediaFielsCubit extends Cubit<GroupGetMediaFielsState> {
  GroupGetMediaFielsCubit() : super(GroupGetMediaFielsInitial());

  List<MediaFielsModel> mediaList = [];

  void getMedia({required String groupID}) {
    emit(GroupGetMediaFielsLoading());
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('media')
          .collection('media')
          .snapshots()
          .listen((snapshot) {
        mediaList = [];
        for (var element in snapshot.docs) {
          mediaList.add(MediaFielsModel.fromJson(element.data()));
        }
        emit(GroupGetMediaSuccess());
      });
    } catch (e) {
      emit(GroupGetMediaFielsFailure(errorMessage: e.toString()));
      debugPrint('error from get media method: ${e.toString()}');
    }
  }
}
