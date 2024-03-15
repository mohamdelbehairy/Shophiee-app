import 'dart:io';

import 'package:app/cubit/pick_file/pick_file_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PickFileCubit extends Cubit<PickFileState> {
  PickFileCubit() : super(PickFileInital());

  File? selectedFile;
  Future<void> pickFile({required List<String> allowedExtensions}) async {
    try {
      final returnFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:allowedExtensions,
      );
      if (returnFile != null) {
        selectedFile = File(returnFile.files.first.path!);
        debugPrint('selectedFile: $selectedFile');
        emit(PickFileSuccess(file: selectedFile!));
      }
    } catch (e) {
      emit(PickFileFailure(errorMessage: e.toString()));
      debugPrint('error from pick file cubit: ${e.toString()}');
    }
  }

  Future<void> downloadAndOpenFile(
      {required String fileUrl, required String fileName}) async {
    try {
      String localPath =
          await downloadFileToLocalPath(fileUrl: fileUrl, fileName: fileName);

      OpenFile.open(localPath);
    } catch (e) {
      debugPrint('Error downloading and opening file: $e');
    }
  }

  Future<String> downloadFileToLocalPath(
      {required String fileUrl, required String fileName}) async {
    try {
      String tempDir = (await getTemporaryDirectory()).path;
      await FirebaseStorage.instance
          .refFromURL(fileUrl)
          .writeToFile(File('$tempDir/$fileName'));
      return '$tempDir/$fileName';
    } catch (e) {
      debugPrint('Error downloading file: $e');
      rethrow;
    }
  }
}
