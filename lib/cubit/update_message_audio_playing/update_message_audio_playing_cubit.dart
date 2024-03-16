import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'update_message_audio_playing_state.dart';

class UpdateMessageAudioPlayingCubit
    extends Cubit<UpdateMessageAudioPlayingState> {
  UpdateMessageAudioPlayingCubit() : super(UpdateMessageAudioPlayingInitial());

  Future<void> updateMessageAudioPlaying(
      {required String friendID, required String messageID}) async {
    emit(UpdateMessageAudioPlayingLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(friendID)
          .collection('messages')
          .doc(messageID)
          .update({'messageSoundPlaying': true});
      emit(UpdateMessageAudioPlayingSuccess());
    } catch (e) {
      emit(UpdateMessageAudioPlayingFailure(errroMessage: e.toString()));
      debugPrint(
          'error from update from update message audio playing: ${e.toString()}');
    }
  }
}
