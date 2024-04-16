import 'package:app/constants.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/upload/upload_image/upload_image_cubit.dart';
import 'package:app/cubit/user_date/store_user_date/store_user_date_cubit.dart';
import 'package:app/widgets/create_accont_widget/custom_add_user_date_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddUserDataPageBody extends StatelessWidget {
  const AddUserDataPageBody(
      {super.key,
      required this.storeUserData,
      required this.uploadImage,
      required this.size,
      required this.pickImage});

  final StoreUserDateCubit storeUserData;
  final UploadImageCubit uploadImage;
  final Size size;
  final PickImageCubit pickImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreUserDateCubit, StoreUserDateState>(
      listener: (context, storeState) {
        if (storeState is StoreUserDateLoading) {
          storeUserData.isLoading = storeState.isLoading;
        }
      },
      builder: (context, storeState) {
        return BlocConsumer<UploadImageCubit, UploadImageState>(
          listener: (context, uploadState) {
            if (uploadState is UploadImageLoading) {
              uploadImage.isLoading = uploadState.isLoading;
            }
          },
          builder: (context, uploadState) {
            return ModalProgressHUD(
                inAsyncCall: uploadImage.isLoading == false
                    ? storeUserData.isLoading
                    : uploadImage.isLoading,
                progressIndicator: Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                        color: kPrimaryColor, size: 50)),
                child: CustomAddUserDataPageBody(
                    size: size,
                    pickImage: pickImage,
                    storeUserDate: storeUserData,
                    uploadImage: uploadImage));
          },
        );
      },
    );
  }
}
