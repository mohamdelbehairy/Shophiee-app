import 'package:app/cubit/get_followers/get_followers_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  GetFollowersCubit() : super(GetFollowersInitial());

  List<UserModel> followers = [];
  void getFollowers() {
    emit(GetFollowersLoading());
    try {
      FirebaseFirestore.instance
          .collection('following')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('following')
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          followers =
              snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
          if (followers.isNotEmpty) {
            int numberOfFollowers = followers.length;
            emit(GetFollowersSuccess(numberOfFollowers: numberOfFollowers));
          }
        }
      });
    } catch (e) {
      emit(GetFollowersFailure(errorMessage: e.toString()));
      debugPrint('error from get follow result cubit: ${e.toString()}');
    }
  }
}
