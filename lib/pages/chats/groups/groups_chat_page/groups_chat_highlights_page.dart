import 'package:app/constants.dart';
import 'package:app/cubit/groups/high_light_group_message/hight_light_messages/hight_light_messages_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_app_bar_action_icon.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_page_body.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/no_high_light_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatHighLightsPage extends StatelessWidget {
  const GroupsChatHighLightsPage(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var hightLightMessage = context.read<HightLightMessagesCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: Text('Highlight messages',
            style: TextStyle(
                color: Colors.white,
                fontSize: size.height * .025,
                fontWeight: FontWeight.normal)),
        actions: [
          GroupsHighLightAppBarActionIcon(
              size: size,
              hightLightMessage: hightLightMessage,
              groupModel: groupModel)
        ],
      ),
      body: BlocBuilder<HightLightMessagesCubit, HightLightMessagesState>(
        builder: (context, state) {
          return SafeArea(
            child: hightLightMessage.hightLightMessageList.isEmpty
                ? NoHighLighMessages(size: size)
                : GroupsChatHighLightPageBody(
                    hightLightMessage: hightLightMessage,
                    size: size,
                    groupModel: groupModel),
          );
        },
      ),
    );
  }
}
