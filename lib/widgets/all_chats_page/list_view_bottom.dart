import 'package:app/widgets/all_chats_page/item_bottom.dart';
import 'package:flutter/material.dart';

class ListViewBottom extends StatelessWidget {
  const ListViewBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 2,
        (context, index) {
          return ItemBottom();
        },
      ),
    );
  }
}
