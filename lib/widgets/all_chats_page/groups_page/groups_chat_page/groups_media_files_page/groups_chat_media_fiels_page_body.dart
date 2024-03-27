import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_fiels/group_get_media_fiels_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_media_files_page/media/tab_bar_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatMediaFielsPageBody extends StatelessWidget {
  const GroupsChatMediaFielsPageBody(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var mediaList = context.read<GroupGetMediaFielsCubit>();
    mediaList.getMedia(groupID: groupModel.groupID);
    return SafeArea(
        child: Column(children: [
      Expanded(
          child: TabBarView(children: [
        TabBarMedia(mediaList: mediaList, size: size),
        Text('0'),
        Text('00'),
        Text('0'),
        Text('00')
      ]))
    ]));
  }
}
