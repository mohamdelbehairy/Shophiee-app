import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  Future<void> sendMessage(
      {required String receiverID,
      required String messageText,
      required String userName,
      required String profileImage,
      required String userID,
      required String myUserName,
      required String myProfileImage}) async {
    try {
      MessageModel message = MessageModel.fromJson({
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'receiverID': receiverID,
        'messageID': const Uuid().v4(),
        'messageText': messageText,
        'messageDateTime': Timestamp.now(),
        'isSeen': false,
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
          'text':messageText,
          'lastMessageDateTime':Timestamp.now(),
          'lastUserID':userID,
          'isSeen':false,
          'senderID':FirebaseAuth.instance.currentUser!.uid,
          'receiverID':receiverID,
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
          'text':messageText,
          'lastMessageDateTime':Timestamp.now(),
          'lastUserID': FirebaseAuth.instance.currentUser!.uid,
          'isSeen':false,
          'senderID':FirebaseAuth.instance.currentUser!.uid,
          'receiverID':receiverID,
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

  Future<void> updateChatMessageSeen(
      {required String receiverID, required String messageID}) async {
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
  }
}
