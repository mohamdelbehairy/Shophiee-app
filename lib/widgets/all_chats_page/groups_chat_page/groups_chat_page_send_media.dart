import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_image_page.dart';
import 'package:app/utils/widget/chat_choose_media.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_bottom_send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GroupsChatPageSendMedia extends StatefulWidget {
  const GroupsChatPageSendMedia(
      {super.key,
      required this.size,
      required this.scrollController,
      required this.groupModel});
  final Size size;
  final ScrollController scrollController;
  final GroupModel groupModel;

  @override
  State<GroupsChatPageSendMedia> createState() =>
      _GroupsChatPageSendMediaState();
}

class _GroupsChatPageSendMediaState extends State<GroupsChatPageSendMedia> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isClick) ChatChooseMedia(size: widget.size),
        BlocListener<PickImageCubit, PickImageStates>(
          listener: (context, state) {
            if (state is PickImageScucccess) {
              getnav.Get.to(
                  () => GroupsChatPickImagePage(
                      image: state.image, groupModel: widget.groupModel),
                  transition: getnav.Transition.leftToRight);
              setState(() {
                isClick = false;
              });
            }
          },
          child: GroupsChatBottomSendMessage(
            onPressed: () {
              setState(() {
                isClick = !isClick;
              });
            },
            scrollController: widget.scrollController,
            groupModel: widget.groupModel,
          ),
        )
      ],
    );
  }
}
