import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTextReplayContact extends StatelessWidget {
  const CustomMessageTextReplayContact(
      {super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .06,
      width: message.messageText.length > 15
          ? size.height * .28
          : size.height * .18,
      color: message.senderID == FirebaseAuth.instance.currentUser!.uid
          ? Colors.white12
          : Colors.grey.withOpacity(.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  final currentData = state.userModel.firstWhere(
                          (element) => element.userID == currentUser.uid);
                  return Padding(
                    padding: EdgeInsets.only(
                        left: size.width * .02, top: size.height * .004),
                    child: Text(
                        message.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                            ? currentData.userName
                            : user.userName,
                        style: TextStyle(
                            color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                                ? Colors.white
                                : Colors.black)),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
            },
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * .02),
                  Expanded(
                    // width: size.width * .4,
                    child: Text('Contact',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                                ? Colors.white
                                : Colors.black)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
