import 'dart:io';

import 'package:app/cubit/message/message_state.dart';
import 'package:app/models/message_model.dart';
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
    String? imagePath,
    String? videoPath,
    String? filePath,
    File? file,
    File? video,
    String? messageFileName,
    String? phoneContactNumber,
    String? phoneContactName,
    String? replayTextMessage,
    String? replayImageMessage,
    String? replayFileMessage,
    String? replayContactMessage,
  }) async {
    try {
      String? imageUrl;
      String? fileUrl;
      String? videoUrl;
      if (image != null) {
        imageUrl = await uploadMessageImage(imageFile: image, context: context);
      } else if (file != null) {
        fileUrl = await uploadMessageFile(file: file, context: context);
      } else if (video != null) {
        videoUrl = await uploadMessageVideo(videoFile: video, context: context);
      }
      MessageModel message = MessageModel.fromJson({
        'senderID': FirebaseAuth.instance.currentUser!.uid,
        'receiverID': receiverID,
        'messageID': const Uuid().v4(),
        'messageText': messageText,
        'messageDateTime': Timestamp.now(),
        'isSeen': false,
        'groupChatUsersIDSeen': ['1'],
        'messageImage': imageUrl,
        'messageFile': fileUrl,
        'messageVideo': videoUrl,
        'messageImageFile': imagePath,
        'messageVideoFile': videoPath,
        'messageFileFile': filePath,
        'messageFileName': messageFileName,
        'phoneContactNumber': phoneContactNumber,
        'phoneContactName': phoneContactName,
        'replayTextMessage': replayTextMessage,
        'replayImageMessage': replayImageMessage,
        'replayFileMessage': replayFileMessage,
        'replayContactMessage': replayContactMessage,
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
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverID)
          .set({'isTyping': false});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverID)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(message.messageID)
          .set(message.toMap());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverID)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'isTyping': false});

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
          'video': videoUrl,
          'phoneContactNumber': phoneContactNumber,
          'phoneContactName': phoneContactName,
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
          'video': videoUrl,
          'phoneContactNumber': phoneContactNumber,
          'phoneContactName': phoneContactName,
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
    emit(MessageLoading());
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
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_files/$fileName');
      await reference.putFile(file);
      String fileUrl = await reference.getDownloadURL();
      emit(UploadMessageFileSuccess());
      return fileUrl;
    } catch (e) {
      emit(UploadMessageFileFailure(errorMessage: e.toString()));
      debugPrint('error from upload message file method: ${e.toString()}');
      return '';
    }
  }

  Future<String> uploadMessageVideo(
      {required File videoFile, required BuildContext context}) async {
    try {
      String videoName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_videos/$videoName');
      await reference.putFile(videoFile);
      String videoUrl = await reference.getDownloadURL();
      emit(UploadMessageVideoSuccess());
      return videoUrl;
    } on Exception catch (e) {
      emit(UploadMessageVideoFailure(errorMessage: e.toString()));
      debugPrint('error from upload message video method: ${e.toString()}');
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

  Future<bool> isChatsEmpty({required String friendID}) async {
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
      deleteAllMessages(friendID: friendID);
      emit(DeleteChatSuccess());
    } catch (e) {
      debugPrint('error from delete chat method: ${e.toString()}');
    }
  }

  void deleteAllMessages({required String friendID}) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('messages')
          .get()
          .then((value) {
        for (QueryDocumentSnapshot documentSnapshot in value.docs) {
          documentSnapshot.reference.delete();
        }
      });
    } catch (e) {
      debugPrint('error from delete all messages method: ${e.toString()}');
    }
  }

  void isTyping({required String receiverID}) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverID)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.data() != null &&
            snapshot.data()!.containsKey('isTyping')) {
          bool isTyping = snapshot.data()!['isTyping'] ?? false;
          emit(TypingSuccess(isTyping: isTyping));
        }
      });
    } catch (e) {
      debugPrint('error from is typing method: ${e.toString()}');
    }
  }

  Future<void> updateIsTyping(
      {required String receiverID, required bool isTyping}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(receiverID)
          .update({'isTyping': isTyping});
    } catch (e) {
      debugPrint('error from update is typing method: ${e.toString()}');
    }
  }
}
