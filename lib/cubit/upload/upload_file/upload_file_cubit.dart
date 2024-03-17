import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'upload_file_state.dart';

class UploadFileCubit extends Cubit<UploadFileState> {
  UploadFileCubit() : super(UploadFileInitial());

  Future<String> uploadFile({required File file}) async {
    emit(UploadFileLoading());
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref().child('messages_files/$fileName');
      await reference.putFile(file);
      String fileUrl = await reference.getDownloadURL();
      emit(UploadFileSuccess());
      return fileUrl;
    } catch (e) {
      emit(UploadFileFailure(errorMessage: e.toString()));
      debugPrint('error from upload file cubit: ${e.toString()}');
      return '';
    }
  }
}
