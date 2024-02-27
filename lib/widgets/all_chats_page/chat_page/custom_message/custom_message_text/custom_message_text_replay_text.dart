import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageTextReplayText extends StatelessWidget {
  const CustomMessageTextReplayText({super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .05,
      width: size.height * .2,
      color: Colors.white12,
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
                    child: Text(message.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? currentData.userName
                        : user.userName),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: size.width * .02),
                      child: SizedBox(
                        width: size.width * .4,
                        child: Text(message.replayTextMessage!,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
