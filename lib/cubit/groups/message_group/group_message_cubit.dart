import 'package:app/cubit/groups/message_group/group_message_state.dart';
import 'package:app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class GroupMessageCubit extends Cubit<GroupMessageState> {
  GroupMessageCubit() : super(GroupMessageInitial());

  Future<void> sendGroupMessage(
      {required String messageText, required String groupID}) async {
    try {
      MessageModel message = MessageModel.fromJson({
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'receiverID': '',
        'messageID': const Uuid().v4(),
        'messageText': messageText,
        'messageDateTime': Timestamp.now(),
        'isSeen': false,
        // 'messageImage': imageUrl,
        // 'messageFile': fileUrl,
        // 'messageVideo': videoUrl,
        // 'messageImageFile': imagePath,
        // 'messageVideoFile': videoPath,
        // 'messageFileFile': filePath,
        // 'messageFileName': messageFileName,
        // 'phoneContactNumber': phoneContactNumber,
        // 'phoneContactName': phoneContactName,
      });
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('messages')
          .doc(message.messageID)
          .set(message.toMap());
      emit(SendMessageGroupSuccess());
    } catch (e) {
      emit(SendMessageGroupFailure(errorMessage: e.toString()));
      debugPrint('error from send group message: ${e.toString()}');
    }
  }

  List<MessageModel> groupMessageList = [];
  void getGroupMessage({required String groupID}) {
    try {
      FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('messages')
          .orderBy('messageDateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        groupMessageList = [];
        for (var element in snapshot.docs) {
          groupMessageList.add(MessageModel.fromJson(element.data()));
        }
        emit(GetMessageGroupsSuccess());
      });
    } catch (e) {
      debugPrint('error from get group message method: ${e.toString()}');
      emit(GetMessageGroupFailure(errorMessage: e.toString()));
    }
  }
}
