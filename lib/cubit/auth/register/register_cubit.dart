import 'package:app/models/users_model.dart';
import 'package:app/widgets/snackBar.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(
      {required String emailAddress,
      required String password,
      required String userName,
      required BuildContext context}) async {
    emit(RegisterLoading());
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      UserModel userModel = UserModel.fromJson({
        'userName': userName,
        'emailAddress': emailAddress,
        'password': password,
        'userID': userCredential.user!.uid,
        'bio':
            'It is a long established fact that is a reader will be the distracted.',
        'nickName': 'Flutter Developer',
        'profileImage':
            'https://img.freepik.com/free-photo/grandma-taking-care-plants-garden_23-2149518819.jpg?w=1060&t=st=1702578328~exp=1702578928~hmac=473d313f3d04fe87cdae26afd3df6f60aed27dc51de41f7133fe02c813efc264',
        'onlineStatue': Timestamp.now(),
        'isStory': false
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      if (userCredential.user != null) {
        emit(RegisterSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: SnackBarWidget(
              title: 'Ops, An Error Occurred',
              icon: Icons.error_outline,
              color: Color(0xffffc72c41),
              message: 'The password provided is too weak.'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: SnackBarWidget(
                title: 'Ops, An Error Occurred',
                icon: Icons.error_outline,
                color: Color(0xffffc72c41),
                message: 'The account already exists for that email.')));
      }
    } catch (e) {
      debugPrint('error from register cubit: ${e.toString()}');
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    emit(SignOutSuccess());
  }
}
