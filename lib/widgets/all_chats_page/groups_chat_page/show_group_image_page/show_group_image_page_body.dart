import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/show_group_image_page/icon.settings_group_image.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/show_group_image_page/icon_close_group_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowGroupImagePageBody extends StatelessWidget {
  const ShowGroupImagePageBody(
      {super.key, required this.groupModel, required this.size});
  final GroupModel groupModel;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.width * .2),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(groupModel.groupImage!),
                  fit: BoxFit.fitWidth)),
        ),
        IconCloseGroupImage(size: size),
        IconSettingsGroupImage(size: size, groupModel: groupModel)
      ],
    );
  }
}
