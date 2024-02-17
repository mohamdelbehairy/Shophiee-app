import 'dart:io';

import 'package:app/common/navigation.dart';
import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_image_page_bottom.dart';
import 'package:app/widgets/all_chats_page/custom_chat_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickImagePage extends StatelessWidget {
  const PickImagePage({super.key, required this.image, required this.user});
  final File image;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
    var sendMessage = context.read<MessageCubit>();
    void navigation() {
      Navigation.navigationTwoPop(context: context);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * .05),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(image), fit: BoxFit.fitWidth),
            ),
          ),
          Positioned(
            bottom: size.height * 0.04,
            width: size.width,
            child: CustomChatTextField(
              hintText: 'Enter Message ....',
              controller: controller,
            ),
          ),
          BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  final userData = state.userModel.firstWhere(
                      (element) => element.userID == currentUser.uid);
                  return Positioned(
                    bottom: size.height * .04,
                    right: size.width * .025,
                    child: PickImagePageBottom(
                        icon: Icons.send,
                        color: kPrimaryColor,
                        onTap: () async {
                          await sendMessage.sendMessage(
                              context: context,
                              receiverID: user.userID,
                              image: image,
                              file: null,
                              messageText: controller.text,
                              userName: user.userName,
                              profileImage: user.profileImage,
                              userID: user.userID,
                              myUserName: userData.userName,
                              myProfileImage: userData.profileImage);
                          navigation();
                        }),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
          Positioned(
            top: size.height * .15,
            left: size.width * .04,
            child: PickImagePageBottom(
              icon: FontAwesomeIcons.xmark,
              color: Colors.transparent,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
