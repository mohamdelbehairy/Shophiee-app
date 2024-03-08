import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/edit_profile_page/edit_profile_image_bottom_sheet.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage(
      {super.key,
      required this.user,
      required this.takePhoto,
      required this.choosePhoto});
  final UserModel user;
  final Function() takePhoto;
  final Function() choosePhoto;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return Stack(
      children: [
        BlocBuilder<PickImageCubit, PickImageStates>(
          builder: (context, state) {
            if (state is PickImageScucccess) {
              return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                builder: (context, state) {
                  if (state is GetUserDataSuccess &&
                      state.userModel.isNotEmpty) {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final userData = state.userModel.firstWhere(
                          (element) => element.userID == currentUser.uid);
                      return CircleAvatar(
                        radius: size.width * .15,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(size.width * .15),
                          child: FancyShimmerImage(
                              boxFit: BoxFit.cover,
                              shimmerBaseColor: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade300,
                              shimmerHighlightColor: isDark
                                  ? Colors.white24
                                  : Colors.grey.shade100,
                              imageUrl: userData.profileImage),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return CircleAvatar(
                radius: size.width * .15,
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.width * .15),
                  child: FancyShimmerImage(
                      boxFit: BoxFit.cover,
                      shimmerBaseColor:
                          isDark ? Colors.white12 : Colors.grey.shade300,
                      shimmerHighlightColor:
                          isDark ? Colors.white24 : Colors.grey.shade100,
                      imageUrl: user.profileImage),
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => showModalBottomSheet(
                backgroundColor: isDark ? Color(0xff2b2c33) : Colors.white,
                context: context,
                builder: (context) => EditProfileImageBottomSheet(
                    takePhoto: takePhoto, choosePhoto: choosePhoto)),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: size.width * .048,
              child: CircleAvatar(
                radius: size.width * .043,
                backgroundColor: kPrimaryColor,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
