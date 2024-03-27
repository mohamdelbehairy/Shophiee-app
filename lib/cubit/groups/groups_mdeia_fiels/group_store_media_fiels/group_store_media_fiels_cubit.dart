import 'package:app/models/media_fiels_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
part 'group_store_media_fiels_state.dart';

class GroupStoreMediaFielsCubit extends Cubit<GroupStoreMediaFielsState> {
  GroupStoreMediaFielsCubit() : super(GroupStoreMediaFielsInitial());

  Future<void> storeMedia(
      {required String groupID,
      String? messageImage,
      String? messageVideo,
      String? messageText}) async {
    emit(GroupStoreMediaFielsLoading());
    try {
      MediaFielsModel mediaFielsModel = MediaFielsModel.fromJson({
        'messageID': Uuid().v4(),
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'messageImage': messageImage,
        'messageVideo': messageVideo,
        'messageText': messageText,
        'dateTime': Timestamp.now(),
      });
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('media')
          .collection('media')
          .doc(mediaFielsModel.messageID)
          .set(mediaFielsModel.toMap());
      emit(GroupStoreMediaFielsStoreMediaSuccess());
    } catch (e) {
      emit(GroupStoreMediaFielsFailure(errorMessage: e.toString()));
      debugPrint('error from store media method: ${e.toString()}');
    }
  }
}
