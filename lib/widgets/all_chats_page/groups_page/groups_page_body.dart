import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_page.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_my_groups.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_create_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GroupsPageBody extends StatelessWidget {
  const GroupsPageBody({super.key, required this.group});

  final CreateGroupsCubit group;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupsCubit, CreateGroupsState>(
      builder: (context, state) {
        List<GroupModel> filteredGroups =
            group.userGroupsList.where((userGroup) {
          return userGroup.usersID
              .contains(FirebaseAuth.instance.currentUser!.uid);
        }).toList();
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: filteredGroups.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .9,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CustomCreateGroup();
                } else {
                  return GestureDetector(
                    onTap: () => getnav.Get.to(
                        () => GroupsChatPage(
                            groupModel: filteredGroups[index - 1]),
                        transition: getnav.Transition.leftToRight),
                    child:
                        CustomMyGroups(groupModel: filteredGroups[index - 1]),
                  );
                }
              }),
        );
      },
    );
  }
}
