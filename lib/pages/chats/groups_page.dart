import 'package:app/widgets/all_chats_page/groups_page/custom_add_groups.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_create_group.dart';
import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16,right: 16,top: 16),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
            itemCount: 10,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .9,
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return CustomCreateGroup();
              } else {
                return CustomAddGroups();
              }
            }),
      ),
    );
  }
}


// CustomCreateGroup()