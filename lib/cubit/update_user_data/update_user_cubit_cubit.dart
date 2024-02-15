import 'package:app/constants.dart';
import 'package:app/cubit/update_user_data/update_user_data_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateUserDataCubit extends Cubit<UpdateUserDataStates> {
  UpdateUserDataCubit() : super(UpdateUserDataInitial());

  bool isSelected = false;

  Future<void> updateUserData(
      {required String field, required String userInfo}) async {
    try {
      if (field == bioField) {
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({field: userInfo});
        emit(UpdateUserBioSuccess());
      } else if (field == userNameField) {
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({field: userInfo});
        emit(UpdateUserUserNameSuccess());
      } else if (field == nickNameField) {
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({field: userInfo});
        emit(UpdateUserNickNameSuccess());
      } else {
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({field: userInfo});
        emit(UpdateUserDataSuccess());
      }
    } catch (e) {
      emit(UpdateUserFailure(errorMessage: e.toString()));
    }
  }

  String profileImageUrl = '';
  Future<void> uploadProfileImage({required dynamic selectedImage}) async {
    if (selectedImage == null) {
      emit(UpdateUserDataLoading(isSelected: false));
      return;
    } else {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(selectedImage.path).pathSegments.last}')
          .putFile(selectedImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          emit(UpdateProfileImageSuccess());
          print(value);
          profileImageUrl = value;
          updateUserData(field: profileImageField, userInfo: profileImageUrl);
          isSelected = false;
        }).catchError((error) {
          emit(UpdateProfileImageFailure(errorMessage: error.toString()));
          print(error.toString());
        });
      }).catchError((error) {
        emit(UpdateProfileImageFailure(errorMessage: error.toString()));
        print(error.toString());
      });
      emit(UpdateUserDataLoading(isSelected: true));
    }
  }
}
