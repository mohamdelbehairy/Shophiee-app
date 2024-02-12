import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/chats/chats_state.dart';
import 'package:app/widgets/all_chats_page/item_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewBottom extends StatefulWidget {
  const ListViewBottom({super.key});

  @override
  State<ListViewBottom> createState() => _ListViewBottomState();
}

class _ListViewBottomState extends State<ListViewBottom> {
  @override
  void initState() {
    super.initState();
    context.read<ChatsCubit>().chats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        if (state is ChatsSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.users.length,
              (context, index) {
                return ItemBottom();
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
