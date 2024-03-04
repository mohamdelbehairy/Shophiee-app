import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/pages/edit_profile_page.dart';
import 'package:app/widgets/profile_page/profile_page_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
        builder: (context, state) {
          if (state is GetUserDataLoading) {
            return Center(
                child: LoadingAnimationWidget.prograssiveDots(
                    color: kPrimaryColor, size: 50));
          } else if (state is GetUserDataSuccess &&
              state.userModel.isNotEmpty) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              final userData = state.userModel
                  .firstWhere((element) => element.userID == currentUser.uid);
              TextEditingController controller =
                  TextEditingController(text: userData.bio);
              return ProfilePageBody(
                user: userData,
                onTap: () {
                  getnav.Get.to(
                      () => EditProfilePage(
                          user: userData, controller: controller),
                      transition: getnav.Transition.leftToRight);
                },
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
  }
}
