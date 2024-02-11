import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/story/story_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/story_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatItemTop extends StatelessWidget {
  const ChatItemTop({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    Color color;
    var isStory =
        context.read<StoryCubit>().checkIsStory(friendId: user.userID);
    navigatorPush() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StoryViewPage(user: user)));
    }

    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (await isStory) {
              navigatorPush();
            }
          },
          child: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
            builder: (context, state) {
              if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
                final currentUser = user.userID;
                final data = state.userModel
                    .firstWhere((element) => element.userID == currentUser);

                if (data.onlineStatue.minute ==
                    Timestamp.now().toDate().minute) {
                  color = kPrimaryColor;
                } else {
                  color = Colors.grey;
                }
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: size.width * .075,
                      backgroundColor:
                          data.isStory! ? kPrimaryColor : Colors.transparent,
                      child: CircleAvatar(
                        radius: size.width * .069,
                        backgroundColor:
                            data.isStory! ? Colors.white : Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff2b2c33).withOpacity(.05),
                          radius: size.width * .063,
                          backgroundImage: NetworkImage(user.profileImage),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          bottom: size.width * .01, end: size.width * .001),
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
              } else {
                return Container();
              }
            },
          ),
        ),
        SizedBox(height: size.width * .01),
        Container(
          width: size.width * .16,
          child: Center(
            child: Text(
              user.userName.split(' ')[0],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
