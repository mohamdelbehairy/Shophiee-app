import 'package:app/constants.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFriendsBottomMessage extends StatelessWidget {
  const MyFriendsBottomMessage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.read<MessageCubit>().getMessage(receiverID: user.userID);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatPage(user: user)));
      },
      child: Container(
        height: size.height * .045,
        width: size.width * .2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * .04),
          color: kPrimaryColor,
          border: Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: Text(
            'Message',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
