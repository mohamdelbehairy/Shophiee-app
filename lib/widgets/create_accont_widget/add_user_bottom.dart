import 'package:app/constants.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/cubit/upload/upload_image/upload_image_cubit.dart';
import 'package:app/cubit/user_date/store_user_date/store_user_date_cubit.dart';
import 'package:app/pages/create_account/verificaton_page.dart';
import 'package:app/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class AddUserBottom extends StatelessWidget {
  const AddUserBottom(
      {super.key,
      required this.globalKey,
      required this.size,
      required this.email,
      required this.fullName,
      required this.dateOfBirth,
      required this.nickName,
      required this.storeUserDate,
      required this.gender,
      required this.bio,
      required this.uploadImage,
      required this.pickImage,
      required this.phoneNumber,
      required this.phoneController});

  final GlobalKey<FormState> globalKey;
  final Size size;
  final TextEditingController email;
  final TextEditingController fullName;
  final TextEditingController dateOfBirth;
  final TextEditingController nickName;
  final TextEditingController gender;
  final TextEditingController bio;
  final TextEditingController phoneController;
  final StoreUserDateCubit storeUserDate;
  final UploadImageCubit uploadImage;
  final PickImageCubit pickImage;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PickImageCubit, PickImageStates>(
      listener: (context, state) {
        if (state is PickImageSucccess) {
          pickImage.selectedImage = state.image;
        }
      },
      child: CustomBottom(
          text: 'Continue',
          colorBottom: kPrimaryColor,
          colorText: Colors.white,
          onPressed: () async {
            if (globalKey.currentState!.validate()) {
              globalKey.currentState!.save();
              String profileImage;
              if (pickImage.selectedImage != null) {
                profileImage = await uploadImage.uploadImage(
                    imageFile: pickImage.selectedImage!,
                    fieldName: 'user_images');
              } else {
                profileImage = defaultProfileImageUrl;
              }

              await storeUserDate.storeUserData(
                  emailAddress: email.text,
                  userName: fullName.text,
                  dateOfBirth: dateOfBirth.text,
                  nickName: nickName.text,
                  bio: bio.text,
                  gender: gender.text,
                  phoneNumber:
                      phoneController.text.isNotEmpty ? phoneNumber! : null,
                  profileImage: profileImage);

              getnav.Get.to(() => VerificationPage(isDark: false),
                  transition: getnav.Transition.leftToRight);
            }
          },
          borderRadius: BorderRadius.circular(size.width * .08),
          width: size.width),
    );
  }
}
