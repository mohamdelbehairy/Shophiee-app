import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_members_page/groups_chat_members_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatMembersPageListView extends StatelessWidget {
  const GroupsChatMembersPageListView(
      {super.key, required this.groupModel, required this.size});
  final GroupModel groupModel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: groupModel.usersID.length,
            itemBuilder: (context, index) {
              return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                builder: (context, state) {
                  if (state is GetUserDataSuccess &&
                      state.userModel.isNotEmpty) {
                    final userID = groupModel.usersID[index];
                    final userData = state.userModel
                        .firstWhere((element) => element.userID == userID);

                    return GroupsChatMembersListTile(
                        userData: userData, size: size, groupModel: groupModel);
                  } else {
                    return Container();
                  }
                },
              );
            }));
  }
}
