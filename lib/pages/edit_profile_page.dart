import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/cubit/update_user_data/update_user_cubit_cubit.dart';
import 'package:app/cubit/update_user_data/update_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/edit_profile_page/edit_profile_page_body.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage(
      {super.key, required this.controller, required this.user});
  final TextEditingController controller;
  final UserModel user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserDataCubit, UpdateUserInfoStates>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          ShowToast(
              context: context,
              position: StyledToastPosition.bottom,
              showToastText:
                  'Your profile picture has been updated successfully.');
        } else if (state is UpdateUserLoading) {
          var cubit = BlocProvider.of<UpdateUserDataCubit>(context);
          cubit.isSelected = state.isSelected;
        } else if (state is UpdateUserBioSuccess) {
          ShowToast(
              position: StyledToastPosition.bottom,
              context: context,
              showToastText: 'Your profile bio has been updated successfully.');
        } else if (state is UpdateUserUserNameSuccess) {
          ShowToast(
              position: StyledToastPosition.bottom,
              context: context,
              showToastText: 'Your user name has been updated successfully');
        } else if (state is UpdateUserNickNameSuccess) {
          ShowToast(
              position: StyledToastPosition.bottom,
              context: context,
              showToastText: 'Your nick name has been updated successfully');
        }
      },
      builder: (context, state) {
        var updateUserData = context.read<UpdateUserDataCubit>();
        var pickImage = context.read<PickImageCubit>();
        return ModalProgressHUD(
          inAsyncCall: updateUserData.isSelected,
          progressIndicator: Center(
            child: LoadingAnimationWidget.prograssiveDots(
                color: kPrimaryColor, size: 50),
          ),
          child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  final userData = state.userModel.firstWhere(
                      (element) => element.userID == currentUser.uid);
                  return Scaffold(
                    appBar: AppBar(
                      titleSpacing: -5,
                      title: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: kPrimaryColor,
                      leading: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          context
                              .read<PickImageCubit>()
                              .emit(PickImageInitial());
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    body: EditProfilePageBody(
                      takePhoto: () async {
                        Navigator.pop(context);
                        await pickImage.pickImage(source: ImageSource.camera);
                        await updateUserData.uploadProfileImage(
                            selectedImage: pickImage.selectedImage);
                        pickImage.selectedImage = null;
                      },
                      choosePhoto: () async {
                        Navigator.pop(context);
                        await pickImage.pickImage(source: ImageSource.gallery);
                        await updateUserData.uploadProfileImage(
                            selectedImage: pickImage.selectedImage);
                        pickImage.selectedImage = null;
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
