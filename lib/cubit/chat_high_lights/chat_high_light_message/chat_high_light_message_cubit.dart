import 'package:app/models/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'chat_high_light_message_state.dart';

class ChatHighLightMessageCubit extends Cubit<ChatHighLightMessageState> {
  ChatHighLightMessageCubit() : super(ChatHighLightMessageInitial());

  Future<void> storeChatHighLightMessage(
      {required String friendID, required MessageModel messageModel}) async {
    emit(ChatHighLightMessageLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('highlightMessage')
          .doc(messageModel.messageID)
          .set(messageModel.toMap());
      emit(ChatStoreHighLightMessageSuccess());
    } catch (e) {
      emit(ChatHighLightMessageFailure(errorMessage: e.toString()));
      debugPrint(
          'error message from store chat hight light message: ${e.toString()}');
    }
  }

  Future<void> removeChatHighLightMessage(
      {required String friendID, required MessageModel messageModel}) async {
    emit(ChatHighLightMessageLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('highlightMessage')
          .doc(messageModel.messageID)
          .delete();
      emit(ChatRemoveHighLightMessageSuccess());
    } catch (e) {
      emit(ChatHighLightMessageFailure(errorMessage: e.toString()));
      debugPrint(
          'error message from remove chat hight light message: ${e.toString()}');
    }
  }

  List<MessageModel> hightLightMessageList = [];

  void getHightLightMessage({required String friendID}) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('highlightMessage')
          .orderBy('messageDateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        hightLightMessageList = [];
        for (var element in snapshot.docs) {
          hightLightMessageList.add(MessageModel.fromJson(element.data()));
        }
        emit(ChatGetHighLightMessageSuccess());
      });
    } catch (e) {
      emit(ChatHighLightMessageFailure(errorMessage: e.toString()));
      debugPrint('error from get chat hight light message: ${e.toString()}');
    }
  }
}
