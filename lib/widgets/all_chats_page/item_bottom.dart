import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBottom extends StatelessWidget {
  const ItemBottom({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    final size = MediaQuery.of(context).size;
    Color color;
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                user.userName,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: size.width * .02),
              if (user.lastMessage?['senderID'] !=
                      FirebaseAuth.instance.currentUser!.uid &&
                  !user.lastMessage?['isSeen'])
                Padding(
                  padding: EdgeInsets.only(top: size.width * .012),
                  child: CircleAvatar(
                    radius: size.width * .014,
                    backgroundColor: kPrimaryColor,
                  ),
                )
            ],
          ),
          Text(
            user.formattedTime(),
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: size.width * .03),
          )
        ],
      ),
      leading: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
        builder: (context, state) {
          if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
            final currentUser = user.userID;
            final data = state.userModel
                .firstWhere((element) => element.userID == currentUser);
            if (data.onlineStatue.minute == Timestamp.now().toDate().minute) {
              color = kPrimaryColor;
            } else {
              color = Colors.grey;
            }
            return Stack(
              children: [
                CircleAvatar(
                  radius: size.width * .069,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(user.profileImage),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: CircleAvatar(
                    radius: size.width * .022,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: size.width * .017,
                    ),
                  ),
                )
              ],
            );
          }
          return CircleAvatar();
        },
      ),
      subtitle: Row(
        children: [
          if (user.lastMessage?['senderID'] ==
              FirebaseAuth.instance.currentUser!.uid)
            Icon(Icons.done_all, size: size.width * .045, color: Colors.grey),
          SizedBox(width: size.width * .005),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: size.width * .25),
              child: Text(
                user.lastMessage?['text'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: user.lastMessage?['isSeen'] &&
                            user.lastMessage?['senderID'] !=
                                FirebaseAuth.instance.currentUser!.uid
                        ? Colors.grey
                        : user.lastMessage?['senderID'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? isDark
                                ? Colors.white
                                : Colors.black
                            : isDark
                                ? Colors.white
                                : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
