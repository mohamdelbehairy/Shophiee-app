import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/custom_group_send_text_and_record_item.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_body_list_view.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_send_media.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatPageBody extends StatefulWidget {
  const GroupsChatPageBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupsChatPageBody> createState() => _GroupsChatPageBodyState();
}

class _GroupsChatPageBodyState extends State<GroupsChatPageBody> {
  final scrollController = ScrollController();
  late TextEditingController controller;
  bool isShowSendButton = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    context
        .read<GroupMessageCubit>()
        .getGroupMessage(groupID: widget.groupModel.groupID);
   
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupChat = context.read<GroupMessageCubit>();
    return BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
      builder: (context, state) {
        if (state is GetGroupsMemberSuccess && state.groupsList.isNotEmpty) {
          final groupID = widget.groupModel.groupID;
          final groupData = state.groupsList
              .firstWhere((element) => element.groupID == groupID);
          return Stack(
            children: [
              Column(
                children: [
                  GroupsChatPageBodyListView(
                      scrollController: scrollController,
                      groupModel: groupData),
                  SizedBox(height: size.height * .01),
                  if (groupData.isSendMessages ||
                      groupData.groupOwnerID ==
                          FirebaseAuth.instance.currentUser!.uid ||
                      groupData.adminsID
                          .contains(FirebaseAuth.instance.currentUser!.uid))
                    GroupsChatPageSendMedia(
                        onChanged: (value) {
                          setState(() {
                            isShowSendButton = value.trim().isNotEmpty;
                          });
                        },
                        controller: controller,
                        size: size,
                        scrollController: scrollController,
                        groupModel: groupData),
                  if (!groupData.isSendMessages &&
                      groupData.groupOwnerID !=
                          FirebaseAuth.instance.currentUser!.uid &&
                      !groupData.adminsID
                          .contains(FirebaseAuth.instance.currentUser!.uid))
                    Container(
                      height: size.height * .06,
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * .03),
                      decoration: BoxDecoration(
                          color: Color(0xff2b2c33).withOpacity(.1),
                          borderRadius:
                              BorderRadius.circular(size.width * .04)),
                      child: Center(
                          child: Text(
                              'Sending messages is not allowed in this group.',
                              style: TextStyle(color: Color(0xff878787)))),
                    )
                ],
              ),
              if (groupData.isSendMessages ||
                  groupData.groupOwnerID ==
                      FirebaseAuth.instance.currentUser!.uid ||
                  groupData.adminsID
                      .contains(FirebaseAuth.instance.currentUser!.uid))
                CustomGroupSendTextAndRecordItem(
                    isShowSendButton: isShowSendButton,
                    groupChat: groupChat,
                    controller: controller,
                    widget: widget,
                    scrollController: scrollController,
                    size: size),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
