import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/cubit/groups/selected_friends/selected_friends_cubit.dart';
import 'package:app/widgets/all_chats_page/create_group_page/create_group_page_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var isDark = context.read<LoginCubit>().isDark;
    var selectedFriends = context.read<SelectedFriendsCubit>();
    var createGroup = context.read<CreateGroupsCubit>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: kPrimaryColor,
        title: Text('Create Group',
            style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      body: BlocBuilder<GetFriendsCubit, GetFriendsState>(
        builder: (context, state) {
          if (state is GetFriendsSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.friends.length,
                      itemBuilder: (context, index) {
                        selectedFriends.getFriends();
                        return CreateGroupListTile(
                            isDark: isDark,
                            user: state.friends[index],
                            size: size);
                      }),
                ),
                ElevatedButton(
                    onPressed: () async{
                      await  createGroup.createGroups(
                          usersID: selectedFriends.getFriendsList);
                     for(var friend in selectedFriends.getFriendsList) {
                       selectedFriends.deleteSelectedFriends(selectedFriendID: friend);
                     }
                      if(createGroup.state is CreateGroupsSuccess) {
                        print('selectedFriends: ${selectedFriends.getFriendsList}');
                        print('create group successfully');
                      }
                    },
                    child: Text('create group'))
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
