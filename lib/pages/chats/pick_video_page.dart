import 'dart:io';

import 'package:app/common/navigation.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_chat_text_field.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_item_send_chat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class PickVideoPage extends StatefulWidget {
  const PickVideoPage({super.key, required this.video, required this.user});
  final File video;
  final UserModel user;

  @override
  State<PickVideoPage> createState() => _PickVideoPageState();
}

class _PickVideoPageState extends State<PickVideoPage> {
  late VideoPlayerController _videoPlayerController;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    )..initialize().then((_) {
        setState(() {
          _videoPlayerController.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  void navigation() {
    Navigation.navigationTwoPop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final message = context.read<MessageCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: VideoPlayer(_videoPlayerController)),
          ),
          Positioned(
              top: size.height * .08,
              left: size.width * .05,
              child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(FontAwesomeIcons.xmark, color: Colors.white))),
          Positioned(
            height: size.height * .18,
            width: size.width,
            bottom: 0.0,
            child: PickChatTextField(
              controller: controller,
              hintText: 'Enter a message..',
            ),
          ),
          Positioned(
            width: size.width,
            bottom: size.height * .015,
            child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
              builder: (context, state) {
                if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    final userData = state.userModel.firstWhere(
                        (element) => element.userID == currentUser.uid);
                    return PickItemSendChatItemBottom(
                      user: widget.user,
                      onTap: () async {
                        await message.sendMessage(
                            image: null,
                            file: null,
                            phoneContactNumber: null,
                            phoneContactName: null,
                            video: widget.video,
                            receiverID: widget.user.userID,
                            messageText: controller.text,
                            userName: widget.user.userName,
                            profileImage: widget.user.profileImage,
                            userID: widget.user.userID,
                            myUserName: userData.userName,
                            myProfileImage: userData.profileImage,
                            context: context);
                        navigation();
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
          )
        ],
      ),
    );
  }
}
