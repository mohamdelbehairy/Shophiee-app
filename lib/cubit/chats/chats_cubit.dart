import 'package:app/cubit/chats/chats_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitiail());

  void chats() {
    emit(ChatsLoading());
    try {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('users')
          .orderBy('lastMessage.lastMessageDateTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<Map<String, dynamic>> data =
              snapshot.docs.map((doc) => doc.data()).toList();
          List<UserModel> users = data
              .map((e) => UserModel.fromJson(e))
              .where((element) =>
                  element.userID != FirebaseAuth.instance.currentUser!.uid)
              .toList();
          if (users.isNotEmpty) {
            emit(ChatsSuccess(users: users));
          }
        }
      });
    } catch (e) {
      emit(ChatsFailure(errorMessage: e.toString()));
      debugPrint('error from chats cubit: ${e.toString()}');
    }
  }
}
