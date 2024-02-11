import 'package:app/cubit/all_users/all_users_cubit.dart';
import 'package:app/cubit/all_users/all_users_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/chat_page.dart';
import 'package:app/widgets/all_chats_page/item_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListViewBottom extends StatelessWidget {
  const ChatListViewBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllUsersCubit, GetUserStates>(
      builder: (context, state) {
        if (state is GetUserSuccess) {
          List<UserModel> usersList = state.user;

          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                  ),
                  child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return ChatPage();
                        // }));
                      },
                      child: ChatItemBottom(
                        name: usersList[index].userName,
                        image: usersList[index].profileImage,
                      )),
                );
              });
        } else if (state is GetUserLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
