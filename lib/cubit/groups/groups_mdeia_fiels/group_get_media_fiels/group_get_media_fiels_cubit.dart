import 'package:app/models/media_files_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
part 'group_get_media_fiels_state.dart';

class GroupGetMediaFielsCubit extends Cubit<GroupGetMediaFielsState> {
  GroupGetMediaFielsCubit() : super(GroupGetMediaFielsInitial());

  List<MediaFilesModel> mediaList = [];

  void getMedia({required String groupID}) {
    emit(GroupGetMediaFielsLoading());
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('media')
          .collection('media')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        mediaList = [];
        for (var element in snapshot.docs) {
          mediaList.add(MediaFilesModel.fromJson(element.data()));
        }
        emit(GroupGetMediaSuccess());
      });
    } catch (e) {
      emit(GroupGetMediaFielsFailure(errorMessage: e.toString()));
      debugPrint('error from get media method: ${e.toString()}');
    }
  }

  List<MediaFilesModel> fielsList = [];

  void getFiels({required String groupID}) {
    emit(GroupGetMediaFielsLoading());
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('fiels')
          .collection('fiels')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        fielsList = [];
        for (var element in snapshot.docs) {
          fielsList.add(MediaFilesModel.fromJson(element.data()));
        }
        emit(GroupGetFielsSuccess());
      });
    } catch (e) {
      emit(GroupGetMediaFielsFailure(errorMessage: e.toString()));
      debugPrint('error from get fiels method: ${e.toString()}');
    }
  }
}
