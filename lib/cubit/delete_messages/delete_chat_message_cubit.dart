import 'package:app/models/message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'delete_chat_message_state.dart';

class DeleteChatMessageCubit extends Cubit<DeleteChatMessageState> {
  DeleteChatMessageCubit() : super(DeleteChatMessageInitial());
  Future<void> deleteMessage(
      {required String friendID, required MessageModel message}) async {
    emit(DeleteChatMessageLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('messages')
          .doc(message.messageID)
          .delete();
      await deleteChatMediaFiles(friendID: friendID, messageModel: message);
      emit(DeleteChatMessageSuccess());
    } catch (e) {
      emit(DeleteChatMessageFailure(errorMessage: e.toString()));
      debugPrint('error from delete message method: ${e.toString()}');
    }
  }

  Future<void> deleteChatMediaFiles(
      {required String friendID, required MessageModel messageModel}) async {
    try {
      if (messageModel.messageImage != '' || messageModel.messageVideo != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chats')
            .doc(friendID)
            .collection('mediaFiles')
            .doc('media')
            .collection('media')
            .doc(messageModel.messageID)
            .delete();
      }

      if (messageModel.messageSound != '' || messageModel.messageRecord != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chats')
            .doc(friendID)
            .collection('mediaFiles')
            .doc('voice')
            .collection('voice')
            .doc(messageModel.messageID)
            .delete();
      }

      if (messageModel.messageFile != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chats')
            .doc(friendID)
            .collection('mediaFiles')
            .doc('files')
            .collection('files')
            .doc(messageModel.messageID)
            .delete();
      }
      if (messageModel.messageText.startsWith('http') ||
          messageModel.messageText.startsWith('https')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chats')
            .doc(friendID)
            .collection('mediaFiles')
            .doc('links')
            .collection('links')
            .doc(messageModel.messageID)
            .delete();
      }

      emit(DeleteChatMediaFilesSuccess());
    } catch (e) {
      debugPrint('error from delete group media method: ${e.toString()}');
      emit(DeleteChatMediaFilesFailure(errorMessage: e.toString()));
    }
  }
}
