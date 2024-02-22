import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_state.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/get_following/get_following_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_details.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_bottom.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_connection.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageFriendInfoBottomSheet extends StatefulWidget {
  const ChatPageFriendInfoBottomSheet({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatPageFriendInfoBottomSheet> createState() =>
      _ChatPageFriendInfoBottomSheetState();
}

class _ChatPageFriendInfoBottomSheetState
    extends State<ChatPageFriendInfoBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<GetFollowersCubit>().getFollowers(userID: widget.user.userID);
    context.read<GetFollowingCubit>().getFollowing(userID: widget.user.userID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    var follower = context.read<GetFollowersCubit>();
    var following = context.read<GetFollowingCubit>();
    return Container(
      height: size.height * .36,
      width: size.width,
      decoration: BoxDecoration(
        color: isDark ? Color(0xff2b2c33) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * .04),
          topRight: Radius.circular(size.width * .04),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: size.width * .08,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyFriendPage(user: widget.user)));
              },
              child: Divider(
                thickness: size.width * .01,
                color: Colors.grey.withOpacity(.3),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChatPageFriendInfoListTile(user: widget.user),
              ChatPageFriendInfoBottom(),
            ],
          ),
          SizedBox(height: size.height * .025),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChatPageFriendDetails(textNumber: '532', textType: 'Public Post'),
              BlocBuilder<GetFollowersCubit, GetFollowersState>(
                builder: (context, state) {
                  return ChatPageFriendDetails(
                      textNumber: '${follower.followersList.length}',
                      textType: 'Followers');
                },
              ),
              BlocBuilder<GetFollowingCubit, GetFollowingState>(
                  builder: (context, state) {
                return ChatPageFriendDetails(
                    textNumber: '${following.followingList.length}',
                    textType: 'Following');
              }),
            ],
          ),
          SizedBox(height: size.width * .06),
          ChatPageFriendInfoConnection(
              text: 'Contact Info',
              textInfo: 'Mohamed.myself@gmail.com',
              iconColor: Colors.blue,
              icon: Icons.email),
          SizedBox(height: size.height * .015),
          ChatPageFriendInfoConnection(
              text: 'Phone Call',
              textInfo: '+20 111 5555 555',
              iconColor: kPrimaryColor,
              icon: Icons.call),
        ],
      ),
    );
  }
}
