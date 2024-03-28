import 'package:app/models/media_files_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
part 'group_store_media_files_state.dart';

class GroupStoreMediaFielsCubit extends Cubit<GroupStoreMediaFilesState> {
  GroupStoreMediaFielsCubit() : super(GroupStoreMediaFilesInitial());

  Future<void> storeMedia(
      {required String groupID,
      String? messageImage,
      String? messageVideo,
      String? messageText}) async {
    emit(GroupStoreMediaFilesLoading());
    try {
      MediaFilesModel mediaFilesModel = MediaFilesModel.fromJson({
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
          .doc(mediaFilesModel.messageID)
          .set(mediaFilesModel.toMap());
      emit(GroupStoreMediaFilesStoreMediaSuccess());
    } catch (e) {
      emit(GroupStoreMediaFilessFailure(errorMessage: e.toString()));
      debugPrint('error from store media method: ${e.toString()}');
    }
  }

  Future<void> storeFile({
    required String groupID,
    String? messageFile,
    String? messageFileName,
    double? messageFileSize,
    String? messageFileType,
  }) async {
    emit(GroupStoreMediaFilesLoading());
    try {
      MediaFilesModel mediaFilesModel = MediaFilesModel.fromJson({
        'messageID': Uuid().v4(),
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'messageFile': messageFile,
        'messageFileName': messageFileName,
        'messageFileSize': messageFileSize,
        'messageFileType': messageFileType,
        'dateTime': Timestamp.now(),
      });
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('files')
          .collection('files')
          .doc(mediaFilesModel.messageID)
          .set(mediaFilesModel.toMap());
      emit(GroupStoreMediaFilesStoreFilesSuccess());
    } catch (e) {
      emit(GroupStoreMediaFilessFailure(errorMessage: e.toString()));
      debugPrint('error from store files method: ${e.toString()}');
    }
  }

  Future<void> storeLink({required String groupID, String? messageLink}) async {
    emit(GroupStoreMediaFilesLoading());
    try {
      MediaFilesModel mediaFilesModel = MediaFilesModel.fromJson({
        'messageID': Uuid().v4(),
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'messageLink': messageLink,
        'dateTime': Timestamp.now(),
      });
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('links')
          .collection('links')
          .doc(mediaFilesModel.messageID)
          .set(mediaFilesModel.toMap());
      emit(GroupStoreMediaFilesStoreLinksSuccess());
    } catch (e) {
      emit(GroupStoreMediaFilessFailure(errorMessage: e.toString()));
      debugPrint('error from store links method: ${e.toString()}');
    }
  }

  Future<void> storeVoice(
      {required String groupID,
      String? messageRecord,
      String? messageSound,
      String? messageSoundName}) async {
    emit(GroupStoreMediaFilesLoading());
    try {
      MediaFilesModel mediaFilesModel = MediaFilesModel.fromJson({
        'messageID': Uuid().v4(),
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'messageRecord': messageRecord,
        'messageSound': messageSound,
        'messageSoundName': messageSoundName,
        'dateTime': Timestamp.now(),
      });
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('mediaFiels')
          .doc('voice')
          .collection('voice')
          .doc(mediaFilesModel.messageID)
          .set(mediaFilesModel.toMap());
      emit(GroupStoreMediaFilesStoreVoiceSuccess());
    } catch (e) {
      emit(GroupStoreMediaFilessFailure(errorMessage: e.toString()));
      debugPrint('error from store voice method: ${e.toString()}');
    }
  }
}
