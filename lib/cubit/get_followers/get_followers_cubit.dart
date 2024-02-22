import 'package:app/cubit/get_followers/get_followers_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  GetFollowersCubit() : super(GetFollowersInitial());

  List<UserModel> followersList = [];
  void getFollowers({required String userID}) {
    emit(GetFollowersLoading());
    try {
      FirebaseFirestore.instance
          .collection('following')
          .doc(userID)
          .collection('following')
          .snapshots()
          .listen((snapshot) {
        followersList = [];
        for (var element in snapshot.docs) {
          followersList.add(UserModel.fromJson(element.data()));
        }
        emit(GetFollowersSuccess());
        // if (snapshot.docs.isNotEmpty) {
        //   followersList =
        //       snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
        //   if (followersList.isNotEmpty) {
        //     int numberOfFollowers = followersList.length;
        //     emit(GetFollowersSuccess(numberOfFollowers: numberOfFollowers));
        //   }
        // }
      });
    } catch (e) {
      emit(GetFollowersFailure(errorMessage: e.toString()));
      debugPrint('error from get follow result cubit: ${e.toString()}');
    }
  }
}
