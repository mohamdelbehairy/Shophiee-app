import 'dart:async';

import 'package:app/cubit/story/story_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateUserOnline {
  static void checkOnline() async {
    Timer.periodic(Duration(seconds: 10), (Timer t) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('connection online and good');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'onlineStatue': Timestamp.now()});
        StoryCubit storyCubit = StoryCubit();
        storyCubit.deleteStory();
      }
    });
  }
}
