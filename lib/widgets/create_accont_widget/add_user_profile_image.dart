import 'package:app/constants.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/utils/widget/profile_image/choose_profile_image.dart';
import 'package:app/utils/widget/profile_image/custom_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddUserProfileImage extends StatelessWidget {
  const AddUserProfileImage(
      {super.key, required this.size, required this.pickImage});

  final Size size;
  final PickImageCubit pickImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * .03, bottom: size.height * .02),
      child: Stack(
        children: [
          BlocBuilder<PickImageCubit, PickImageStates>(
            builder: (context, state) {
              if (state is PickImageSucccess) {
                return CircleAvatar(
                    radius: size.width * .15,
                    backgroundColor: Colors.transparent,
                    backgroundImage: FileImage(state.image));
              }
              return CustomProfileImage(
                  size: size, isDark: false, imageUrl: defaultProfileImageUrl);
            },
          ),
          ChooseProfileImage(
              isDark: false,
              takePhoto: () async {
                Navigator.pop(context);
                await pickImage.pickImage(source: ImageSource.camera);
                pickImage.selectedImage = null;
              },
              choosePhoto: () async {
                Navigator.pop(context);
                await pickImage.pickImage(source: ImageSource.gallery);
                pickImage.selectedImage = null;
              },
              size: size)
        ],
      ),
    );
  }
}
