import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_members_page.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_page_info_list_tile.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_details_text.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_item_details.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/groups_chat_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GroupsChatPageInfoDetails extends StatelessWidget {
  const GroupsChatPageInfoDetails(
      {super.key, required this.groupModel, required this.user});
  final GroupModel groupModel;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.0, right: 0.0, top: size.width * .015),
          child: BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
            builder: (context, state) {
              if (state is GetGroupsMemberSuccess &&
                  state.groupsList.isNotEmpty) {
                final groupID = groupModel.groupID;
                final groupData = state.groupsList
                    .firstWhere((element) => element.groupID == groupID);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GroupsChatPageInfoListTile(groupModel: groupData),
                    SizedBox(height: size.height * .01),
                    GroupsDetailsText(size: size),
                    Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
                    SizedBox(height: size.height * .008),
                    ItemDetails(itemName: 'Owner', itemValue: user.userName),
                    ItemDetails(
                        itemName: 'Owner\'s Email',
                        itemValue: user.emailAddress),
                    ItemDetails(itemName: 'Owner\'s Bio', itemValue: user.bio),
                    ItemDetails(
                        itemName: 'Owner\'s Nick Name',
                        itemValue: user.nickName),
                    ItemDetails(
                        itemName: 'Groups\'s Name',
                        itemValue: groupData.groupName),
                    ItemDetails(
                        itemName: 'Number of members',
                        itemValue: '${groupData.usersID.length} members'),
                    Divider(thickness: 2, color: Colors.grey.withOpacity(.1)),
                    GroupsChatComponent(
                        componentName: 'Group Members',
                        onTap: () {
                          getnav.Get.to(() => GroupsChatMembersPage(groupModel: groupData),
                              transition: getnav.Transition.leftToRight);
                        }),
                    GroupsChatComponent(
                        componentName: 'Highlights', onTap: () {}),
                    GroupsChatComponent(
                        componentName: 'Media files', onTap: () {}),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
