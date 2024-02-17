import 'dart:io';

import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/add_story/add_story_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  Future<void> sendMessage({
    required String receiverID,
    required String messageText,
    required String userName,
    required String profileImage,
    required String userID,
    required String myUserName,
    required String myProfileImage,
    required BuildContext context,
    File? image,
    File? file,
    String? messageFileName,
  }) async {
    try {
      String? imageUrl;
      String? fileUrl;
      if (image != null) {
        imageUrl = await uploadMessageImage(imageFile: image, context: context);
      } else if (file != null) {
        fileUrl = await uploadMessageFile(file: file, context: context);
      }
      MessageModel message = MessageModel.fromJson({
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'receiverID': receiverID,
        'messageID': const Uuid().v4(),
        'messageText': messageText,
        'messageDateTime': Timestamp.now(),
        'isSeen': false,
        'messageImage': imageUrl,
        'messageFile': fileUrl,
        'messageFileName':messageFileName,
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverID)
          .collection('messages')
          .doc(message.messageID)
          .set(message.toMap());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverID)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(message.messageID)
          .set(message.toMap());

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('users')
          .doc(receiverID)
          .set({
        'userName': userName,
        'profileImage': profileImage,
        'userID': userID,
        'lastMessage': {
          'text': messageText,
          'image': imageUrl,
          'file': fileUrl,
          'lastMessageDateTime': Timestamp.now(),
          'lastUserID': userID,
          'isSeen': false,
          'senderID': FirebaseAuth.instance.currentUser!.uid,
          'receiverID': receiverID,
        },
      });

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(receiverID)
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'userName': myUserName,
        'profileImage': myProfileImage,
        'userID': FirebaseAuth.instance.currentUser!.uid,
        'lastMessage': {
          'text': messageText,
          'image': imageUrl,
          'file': fileUrl,
          'lastMessageDateTime': Timestamp.now(),
          'lastUserID': FirebaseAuth.instance.currentUser!.uid,
          'isSeen': false,
          'senderID': FirebaseAuth.instance.currentUser!.uid,
          'receiverID': receiverID,
        },
      });

      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageFailure(errorMessage: e.toString()));
      debugPrint('error from send message method: ${e.toString()}');
    }
  }

  List<MessageModel> messages = [];
  void getMessage({required String receiverID}) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverID)
          .collection('messages')
          .orderBy('messageDateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        messages = [];
        for (var message in snapshot.docs) {
          messages.add(MessageModel.fromJson(message.data()));
        }
        emit(GetMessageSuccess());
      });
    } catch (e) {
      emit(GetMessageFailure(errorMessage: e.toString()));
      debugPrint('error from get message method: ${e.toString()}');
    }
  }

  Future<String> uploadMessageImage(
      {required File imageFile, required BuildContext context}) async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddStoryAlertDialog();
          });
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_images/$imageName');
      await reference.putFile(imageFile);
      String imageUrl = await reference.getDownloadURL();
      emit(UploadMessageImageSuccess());
      return imageUrl;
    } catch (e) {
      emit(UploadMessageImageFailure(errorMessage: e.toString()));
      debugPrint('error from upload message image method: ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadMessageFile(
      {required File file, required BuildContext context}) async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddStoryAlertDialog();
          });

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_files/$fileName');
      await reference.putFile(file);
      String fileUrl = await reference.getDownloadURL();
      emit(UploadMessageFileSuccess());
      return fileUrl;
    } catch (e) {
      emit(UploadMessageFileFailure(errorMessage: e.toString()));
      debugPrint('error from upload message image method: ${e.toString()}');
      return '';
    }
  }

  Future<void> updateChatMessageSeen(
      {required String receiverID, required String messageID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverID)
          .collection('messages')
          .doc(messageID)
          .update({'isSeen': true});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverID)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(messageID)
          .update({'isSeen': true});
      updateLastMessageSeen(receiverID: receiverID);
    } catch (e) {
      debugPrint('error from updateChatMessageSeen method: ${e.toString()}');
    }
  }

  Future<void> updateLastMessageSeen({required String receiverID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('users')
          .doc(receiverID)
          .update({'lastMessage.isSeen': true});

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(receiverID)
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'lastMessage.isSeen': true});
    } catch (e) {
      debugPrint('error from updateLastMessageSeen method: ${e.toString()}');
    }
  }

  Future<void> deleteMessage(
      {required String friendID, required String messageID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('messages')
          .doc(messageID)
          .delete();
      emit(DeleteMessageSuccess());
    } catch (e) {
      debugPrint('error from delete message method: ${e.toString()}');
    }
  }

  Future<bool> isChatsEmptey({required String friendID}) async {
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(friendID)
        .collection('messages')
        .get();
    if (document.docs.isEmpty) {
      return true;
    }
    return false;
  }

  Future<void> deleteChat({required String friendID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('users')
          .doc(friendID)
          .delete();
      emit(DeleteChatSuccess());
    } catch (e) {
      debugPrint('error from delete chat method: ${e.toString()}');
    }
  }
}
