import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_settings_state.dart';

class AuthSettingsCubit extends Cubit<AuthSettingsState> {
  AuthSettingsCubit() : super(AuthSettingsInitial());

  Future<void> forgetPassword({required String email}) async {
    emit(AuthSettingsLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(AuthSettingsFailure(errorMessage: e.toString()));
      debugPrint('error from forget password method: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    emit(AuthSettingsLoading());
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      emit(SignOutSuccess());
    } catch (e) {
      emit(AuthSettingsFailure(errorMessage: e.toString()));
      debugPrint('error from sign out method: ${e.toString()}');
    }
  }

  Future<void> verificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      emit(VerificationEmailSuccess());
    } catch (e) {
      emit(AuthSettingsFailure(errorMessage: e.toString()));
      debugPrint('error from verification email method: ${e.toString()}');
    }
  }
}
