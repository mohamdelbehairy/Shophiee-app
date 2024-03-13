import 'package:app/constants.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_state.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/get_following/get_following_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_details.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_bottom.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_connection.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageFriendInfoBottomSheetBody extends StatelessWidget {
  const ChatPageFriendInfoBottomSheetBody(
      {super.key, required this.size, required this.user});
  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var follower = context.read<GetFollowersCubit>();
    var following = context.read<GetFollowingCubit>();
    return Column(
      children: [
        SizedBox(
          width: size.width * .08,
          child: Divider(
            thickness: size.width * .01,
            color: Colors.grey.withOpacity(.3),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChatPageFriendInfoListTile(user: user),
            ChatPageFriendInfoBottom(user: user),
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
    );
  }
}
