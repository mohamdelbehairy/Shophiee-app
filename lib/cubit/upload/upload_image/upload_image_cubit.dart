import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  Future<String> uploadImage({required File imageFile}) async {
    emit(UploadImageLoading());
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_images/$imageName');
      await reference.putFile(imageFile);
      String imageUrl = await reference.getDownloadURL();
      emit(UploadImageSuccess());
      return imageUrl;
    } catch (e) {
      emit(UploadImageFailure(errorMessage: e.toString()));
      debugPrint('error from upload image cubit: ${e.toString()}');
      return '';
    }
  }
}
