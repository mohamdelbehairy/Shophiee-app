import 'dart:io';

import 'package:app/common/navigation.dart';
import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_image_page_bottom.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_item_send_chat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key, required this.image, required this.user});
  final File image;
  final UserModel user;

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  bool isClick = false;
  void navigation() {
    Navigation.navigationOnePop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
    var sendMessage = context.read<MessageCubit>();

    return ModalProgressHUD(
      inAsyncCall: isClick,
      progressIndicator: Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: kPrimaryColor, size: 50)),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * .05),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(widget.image), fit: BoxFit.fitWidth),
              ),
            ),
            Positioned(
              height: size.height * .18,
              width: size.width,
              bottom: 0.0,
              child: PickChatTextField(
                  controller: controller, hintText: 'Enter a message...'),
            ),
            Positioned(
              width: size.width,
              bottom: size.height * .015,
              child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                builder: (context, state) {
                  if (state is GetUserDataSuccess &&
                      state.userModel.isNotEmpty) {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final userData = state.userModel.firstWhere(
                          (element) => element.userID == currentUser.uid);
                      return PickItemSendChatItemBottom(
                          user: widget.user,
                          onTap: () async {
                            try {
                              setState(() {
                                isClick = true;
                              });
                              await sendMessage.sendMessage(
                                  context: context,
                                  receiverID: widget.user.userID,
                                  image: widget.image,
                                  imagePath: widget.image.path,
                                  file: null,
                                  phoneContactNumber: null,
                                  phoneContactName: null,
                                  video: null,
                                  messageText: controller.text,
                                  userName: widget.user.userName,
                                  profileImage: widget.user.profileImage,
                                  userID: widget.user.userID,
                                  myUserName: userData.userName,
                                  myProfileImage: userData.profileImage);
                            } finally {
                              setState(() {
                                isClick = false;
                              });
                              navigation();
                            }
                          });
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
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
      ),
    );
  }
}
