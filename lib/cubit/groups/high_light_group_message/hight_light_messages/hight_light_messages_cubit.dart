import 'package:app/models/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'hight_light_messages_state.dart';

class HightLightMessagesCubit extends Cubit<HightLightMessagesState> {
  HightLightMessagesCubit() : super(HightLightMessagesInitial());

  Future<void> storeHightLightMessages(
      {required String groupID, required MessageModel messageModel}) async {
    emit(HightLightMessagesLoading());
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('hightLightMessages')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageModel.messageID)
          .set(messageModel.toMap());
      emit(StoreHightLightMessagesSuccess());
    } catch (e) {
      emit(StoreHightLightMessagesFailure(errorMessage: e.toString()));
      debugPrint(
          'error message from store hight light message: ${e.toString()}');
    }
  }

  Future<void> removeHightLightMessages(
      {required String groupID, required MessageModel messageModel}) async {
    emit(HightLightMessagesLoading());
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('hightLightMessages')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageModel.messageID)
          .delete();
      emit(RemoveHightLightMessagesSuccess());
    } catch (e) {
      emit(RemoveStoreHightLightMessagesFailure(errorMessage: e.toString()));
      debugPrint(
          'error message from store hight light message: ${e.toString()}');
    }
  }

  List<MessageModel> hightLightMessageList = [];
  void getHightLightMessage({required String groupID}) {
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('hightLightMessages')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .orderBy('messageDateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        hightLightMessageList = [];
        for (var element in snapshot.docs) {
          hightLightMessageList.add(MessageModel.fromJson(element.data()));
        }
        emit(GetHightLightMessagesSuccess());
      });
    } catch (e) {
      emit(GetHightLightMessagesFailure(errorMessage: e.toString()));
      debugPrint('error from get hight light message: ${e.toString()}');
    }
  }
}
