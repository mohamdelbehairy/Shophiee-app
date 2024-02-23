import 'package:app/cubit/groups/selected_friends/selected_friends_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedFriendsCubit extends Cubit<SelectedFriendsState> {
  SelectedFriendsCubit() : super(SelectedFriendsInitial());

  Future<void> selectedFriends(
      {required String selectedFriendID,
      required String userName,
      required String profileImage,
      required String userID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('selectedFriends')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('selectedFriends')
          .doc(selectedFriendID)
          .set({
        'userName': userName,
        'profileImage': profileImage,
        'userID': userID,
      });
      emit(SelectedFriendsSuccess());
    } catch (e) {
      debugPrint('error from selected friends method');
    }
  }

  Future<void> deleteSelectedFriends({required String selectedFriendID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('selectedFriends')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('selectedFriends')
          .doc(selectedFriendID)
          .delete();
      emit(DeleteSelectedFriendsSuccess());
    } catch (e) {
      debugPrint('error from delete selected friends method');
    }
  }

  List<String> getFriendsList = [];
  void getFriends() {
    try {
      FirebaseFirestore.instance
          .collection('selectedFriends')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('selectedFriends')
          .snapshots()
          .listen((snapshot) {
        getFriendsList = [];
        for (var selected in snapshot.docs) {
          getFriendsList.add(selected.data()['userID']);
        }
        emit(GetFriendsSuccess());
      });
    } catch (e) {
      debugPrint('error from get selected friend: ${e.toString()}');
    }
  }
}
