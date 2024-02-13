import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/widgets/all_chats_page/add_story/add_story.dart';
import 'package:app/widgets/all_chats_page/item_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewTop extends StatelessWidget {
  const ListViewTop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .14,
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 4),
        child: BlocBuilder<GetFriendsCubit, GetFriendsState>(
          builder: (context, state) {
            if (state is GetFriendsSuccess) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.friends.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                          padding: EdgeInsets.only(left: 8), child: AddStory());
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: ChatItemTop(user: state.friends[index - 1]));
                    }
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
