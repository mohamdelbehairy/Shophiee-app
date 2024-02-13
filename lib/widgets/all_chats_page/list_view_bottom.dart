import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/chats/chats_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/pages/chats/chat_page.dart';
import 'package:app/widgets/all_chats_page/item_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewBottom extends StatelessWidget {
  const ListViewBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.users.length,
              (context, index) {
                return GestureDetector(
                    onTap: () {
                      context
                          .read<MessageCubit>()
                          .getMessage(receiverID: state.users[index].userID);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatPage(user: state.users[index])));
                    },
                    child: ItemBottom(user: state.users[index]));
              },
            ),
          );
        } else {
          return SliverToBoxAdapter(child: Container());
        }
      },
    );
  }
}
