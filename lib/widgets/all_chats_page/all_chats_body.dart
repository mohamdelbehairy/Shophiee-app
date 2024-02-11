import 'package:app/widgets/all_chats_page/list_view_bottom.dart';
import 'package:app/widgets/all_chats_page/list_view_top.dart';
import 'package:flutter/material.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ListViewTop(),
        ),
        ListViewBottom(),
      ],
    );
  }
}
