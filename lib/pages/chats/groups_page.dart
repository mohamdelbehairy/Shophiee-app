import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/widgets/all_chats_page/groups_page/custom_create_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var group = context.read<CreateGroupsCubit>();
    group.getGroups();
    group.displayGroupIfUserHasAccess();
    return Scaffold(
      body: BlocBuilder<CreateGroupsCubit, CreateGroupsState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: group.userGroupsList.length + 1,
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
                    if (group.userGroupsList[index - 1].usersID
                        .contains(FirebaseAuth.instance.currentUser!.uid)) {
                      return Container(
                        height: 20,
                        width: 30,
                        color: Colors.red,
                        child:
                            Text('data', style: TextStyle(color: Colors.black)),
                      );
                    }
                  }
                }),
          );
        },
      ),
    );
  }
}

// CustomCreateGroup()
