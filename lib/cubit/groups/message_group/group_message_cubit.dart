import 'dart:io';

import 'package:app/cubit/groups/message_group/group_message_state.dart';
import 'package:app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class GroupMessageCubit extends Cubit<GroupMessageState> {
  GroupMessageCubit() : super(GroupMessageInitial());

  Future<void> sendGroupMessage({
    required String messageText,
    required String groupID,
    File? image,
    File? video,
    String? phoneContactNumber,
    String? phoneContactName,
    File? file,
    String? messageFileName,
    String? filePath,
  }) async {
    try {
      String? imageUrl;
      String? videoUrl;
      String? fileUrl;
      if (image != null) {
        imageUrl = await uploadMessageImage(imageFile: image);
      } else if (video != null) {
        videoUrl = await uploadMessageVideo(videoFile: video);
      } else if(file != null) {
        fileUrl = await uploadMessageFile(file: file);
      }
      MessageModel message = MessageModel.fromJson({
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'receiverID': '',
        'messageID': const Uuid().v4(),
        'messageText': messageText,
        'messageDateTime': Timestamp.now(),
        'isSeen': false,
        'groupChatUsersIDSeen': [],
        'messageImage': imageUrl,
        'messageFile': fileUrl,
        'messageVideo': videoUrl,
        // 'messageImageFile': imagePath,
        // 'messageVideoFile': videoPath,
        'messageFileFile': filePath,
        'messageFileName': messageFileName,
        'phoneContactNumber': phoneContactNumber,
        'phoneContactName': phoneContactName,
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

  Future<void> updateGroupsChatMessageSeen({
    required String groupID,
    required String messageID,
    required List<dynamic> groupChatUsersIDSeen,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID)
          .collection('messages')
          .doc(messageID)
          .update({
        'isSeen': true,
        'groupChatUsersIDSeen': FieldValue.arrayUnion(groupChatUsersIDSeen)
      });
    } catch (e) {
      debugPrint(
          'error from update Groups Chat Message Seen method: ${e.toString()}');
    }
  }

  Future<String> uploadMessageImage({required File imageFile}) async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('groups_messages_images/$imageName');
      await reference.putFile(imageFile);
      String imageUrl = await reference.getDownloadURL();
      emit(UploadGroupsMessageImageSuccess());
      return imageUrl;
    } catch (e) {
      emit(UploadGroupsMessageImageFailure(errorMessage: e.toString()));
      debugPrint('error from upload message image method: ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadMessageVideo({required File videoFile}) async {
    try {
      String videoName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('groups_messages_videos/$videoName');
      await reference.putFile(videoFile);
      String videoUrl = await reference.getDownloadURL();
      emit(UploadGroupsMessageVideoSuccess());
      return videoUrl;
    } on Exception catch (e) {
      emit(UploadGroupsMessageVideoFailure(errorMessage: e.toString()));
      debugPrint('error from upload message video method: ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadMessageFile(
      {required File file}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
      FirebaseStorage.instance.ref().child('groups_messages_files/$fileName');
      await reference.putFile(file);
      String fileUrl = await reference.getDownloadURL();
      emit(UploadGroupsMessageFileSuccess());
      return fileUrl;
    } catch (e) {
      emit(UploadGroupsMessageFileFailure(errorMessage: e.toString()));
      debugPrint('error from upload message file method: ${e.toString()}');
      return '';
    }
  }
}
