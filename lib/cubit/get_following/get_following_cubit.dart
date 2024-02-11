import 'package:app/cubit/get_following/get_following_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFollowingCubit extends Cubit<GetFollowingState> {
  GetFollowingCubit() : super(GetFollowingInitial());

  List<UserModel> following = [];
  void getFollowing() {
    emit(GetFollowingLoading());
    try {
      FirebaseFirestore.instance
          .collection('followers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('followers')
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          following =
              snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
          if (following.isNotEmpty) {
            int numberOfFollowing = following.length;
            emit(GetFollowingSuccess(numberOfFollowers: numberOfFollowing));
          }
        }
      });
    } catch (e) {
      emit(GetFollowingFailure(errorMessage: e.toString()));
      debugPrint('error from get follow result cubit: ${e.toString()}');
    }
  }
}
