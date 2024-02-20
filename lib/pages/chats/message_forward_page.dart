import 'package:app/constants.dart';
import 'package:app/cubit/forward_selected_friend/forward_selected_friend_cubit.dart';
import 'package:app/cubit/forward_selected_friend/forward_selected_friend_state.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/message_forward/message_forward_bottom.dart';
import 'package:app/widgets/all_chats_page/chat_page/message_forward/message_forward_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageForwardPage extends StatelessWidget {
  const MessageForwardPage(
      {super.key, required this.user, required this.message});
  final UserModel user;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var selectedFriend = context.read<ForwardSelectedFriendCubit>();
    selectedFriend.getSelectedFriend();

    return BlocBuilder<ForwardSelectedFriendCubit, ForwardSelectedFriendState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: size.width * -.02,
            backgroundColor: kPrimaryColor,
            title: Text(
              selectedFriend.selectedFriendList.isNotEmpty
                  ? '${selectedFriend.selectedFriendList.length} selected'
                  : 'Forward to...',
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
            ),
            leading: GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  await selectedFriend.deleteAllSelectedFriends();
                },
                child: Icon(Icons.arrow_back,
                    color: Colors.white, size: size.width * .08)),
          ),
          body: Stack(
            children: [
              BlocBuilder<GetFriendsCubit, GetFriendsState>(
                builder: (context, state) {
                  if (state is GetFriendsSuccess) {
                    return ListView.builder(
                        itemCount: state.friends.length,
                        itemBuilder: (context, index) {
                          return MessageForwardListTile(
                              user: state.friends[index]);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
              if (selectedFriend.selectedFriendList.isNotEmpty)
                Positioned(
                  bottom: size.height * .02,
                  right: size.width * .04,
                  child: MessageForwardBottom(message: message, user: user),
                )
            ],
          ),
        );
      },
    );
  }
}
