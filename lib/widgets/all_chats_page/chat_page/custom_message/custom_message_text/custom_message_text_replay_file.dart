import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTextReplayFile extends StatelessWidget {
  const CustomMessageTextReplayFile(
      {super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .06,
      width: size.height * .35,
      color: message.senderID == FirebaseAuth.instance.currentUser!.uid
          ? Colors.white12
          : Colors.grey.withOpacity(.3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width * .02),
            child: Container(
              width: size.height * .04,
              child: CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Icon(Icons.insert_drive_file,
                    color: Colors.white, size: size.width * .05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                builder: (context, state) {
                  if (state is GetUserDataSuccess &&
                      state.userModel.isNotEmpty) {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final currentData = state.userModel.firstWhere(
                          (element) => element.userID == currentUser.uid);
                      return Padding(
                        padding: EdgeInsets.only(
                            left: size.width * .02, top: size.height * .008),
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
              Padding(
                padding: EdgeInsets.only(left: size.width * .02),
                child: Text(message.replayFileMessage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Colors.white
                            : Colors.black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
