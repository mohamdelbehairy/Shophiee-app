import 'dart:io';

import 'package:app/common/navigation.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_file_page/pick_file_send_file_item.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_file_page/pick_file_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PickFilePageBody extends StatefulWidget {
  const PickFilePageBody(
      {super.key,
      required this.file,
      required this.user,
      required this.messageFileName});
  final File file;
  final UserModel user;
  final String messageFileName;

  @override
  State<PickFilePageBody> createState() => _PickFilePageBodyState();
}

class _PickFilePageBodyState extends State<PickFilePageBody> {
  TextEditingController controller = TextEditingController();
  void navigation() {
    Navigation.navigationTwoPop(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final message = context.read<MessageCubit>();
    return Stack(
      children: [
        PDFView(
          filePath: widget.file.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          onError: (error) {
            print('error from pdf method: $error');
          },
        ),
        Positioned(
          height: size.height * .18,
          width: size.width,
          bottom: 0.0,
          child: PickFileTextField(controller: controller),
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
                  return PickFileSendFileItem(
                      user: widget.user,
                      onTap: () async {
                        await message.sendMessage(
                            image: null,
                            file: widget.file,
                            messageFileName: widget.messageFileName,
                            receiverID: widget.user.userID,
                            messageText: controller.text,
                            userName: widget.user.userName,
                            profileImage: widget.user.profileImage,
                            userID: widget.user.userID,
                            myUserName: userData.userName,
                            myProfileImage: userData.profileImage,
                            context: context);
                        navigation();
                      });
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
    );
  }
}
