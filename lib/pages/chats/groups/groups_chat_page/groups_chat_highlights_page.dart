import 'package:app/constants.dart';
import 'package:app/cubit/groups/high_light_group_message/hight_light_messages/hight_light_messages_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          Icon(FontAwesomeIcons.ellipsisVertical, size: size.height * .025)
        ],
      ),
      body: SafeArea(
        child: GroupsChatHighLightPageBody(
            hightLightMessage: hightLightMessage,
            size: size,
            groupModel: groupModel),
      ),
    );
  }
}
