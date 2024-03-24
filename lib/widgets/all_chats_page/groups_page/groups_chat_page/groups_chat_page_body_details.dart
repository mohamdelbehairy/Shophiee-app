import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/custom_group_send_text_and_record_item.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_body_list_view.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_chat_page_send_media.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatPageBodyDetails extends StatelessWidget {
  const GroupsChatPageBodyDetails(
      {super.key,
      required this.groupModel,
      required this.scrollController,
      required this.controller,
      required this.isShowSendButton,
      required this.onChanged,
      required this.size});
  final GroupModel groupModel;
  final ScrollController scrollController;
  final TextEditingController controller;
  final bool isShowSendButton;
  final Function(String) onChanged;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            GroupsChatPageBodyListView(
                scrollController: scrollController, groupModel: groupModel),
            SizedBox(height: size.height * .01),
            if (groupModel.isSendMessages ||
                groupModel.groupOwnerID ==
                    FirebaseAuth.instance.currentUser!.uid ||
                groupModel.adminsID
                    .contains(FirebaseAuth.instance.currentUser!.uid))
              GroupsChatPageSendMedia(
                  onChanged: onChanged,
                  controller: controller,
                  size: size,
                  scrollController: scrollController,
                  groupModel: groupModel),
            if (!groupModel.isSendMessages &&
                groupModel.groupOwnerID !=
                    FirebaseAuth.instance.currentUser!.uid &&
                !groupModel.adminsID
                    .contains(FirebaseAuth.instance.currentUser!.uid))
              Container(
                height: size.height * .06,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: size.width * .03),
                decoration: BoxDecoration(
                    color: Color(0xff2b2c33).withOpacity(.1),
                    borderRadius: BorderRadius.circular(size.width * .04)),
                child: Center(
                    child: Text(
                        'Sending messages is not allowed in this group.',
                        style: TextStyle(color: Color(0xff878787)))),
              )
          ],
        ),
        if (groupModel.isSendMessages ||
            groupModel.groupOwnerID == FirebaseAuth.instance.currentUser!.uid ||
            groupModel.adminsID
                .contains(FirebaseAuth.instance.currentUser!.uid))
          CustomGroupSendTextAndRecordItem(
              isShowSendButton: isShowSendButton,
              controller: controller,
              groupModel: groupModel,
              scrollController: scrollController,
              size: size),
      ],
    );
  }
}
