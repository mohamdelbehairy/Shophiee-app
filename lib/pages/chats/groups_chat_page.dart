import 'package:app/constants.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/groups/message_group/group_message_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chats_icons_app_bar_button.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPage extends StatefulWidget {
  const GroupsChatPage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<GroupsChatPage> createState() => _GroupsChatPageState();
}

class _GroupsChatPageState extends State<GroupsChatPage> {
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    context
        .read<GroupMessageCubit>()
        .getGroupMessage(groupID: widget.groupModel.groupID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupChat = context.read<GroupMessageCubit>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: GroupsChatPageAppBar(groupModel: widget.groupModel),
        actions: [
          ChatsIconsAppBarButton(icon: Icons.call),
          ChatsIconsAppBarButton(icon: FontAwesomeIcons.video),
          ChatsIconsAppBarButton(icon: Icons.error),
        ],
      ),
      body: BlocConsumer<GroupMessageCubit, GroupMessageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount: groupChat.groupMessageList.length,
                    itemBuilder: (context, index) {
                      var message = context
                          .read<GroupMessageCubit>()
                          .groupMessageList[index];
                      if (message.senderID ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 100,
                            color: kPrimaryColor,
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .03,
                                vertical: size.width * .003),
                            child: Center(child: Text(message.messageText)),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 100,
                            color: kPrimaryColor,
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .03,
                                vertical: size.width * .003),
                            child: Center(child: Text(message.messageText)),
                          ),
                        );
                      }
                    }),
              ),
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        await groupChat.sendGroupMessage(
                            messageText: controller.text,
                            groupID: widget.groupModel.groupID);
                        controller.clear();
                        _controller.animateTo(0,
                            duration: const Duration(microseconds: 20),
                            curve: Curves.easeIn);
                      },
                      child: Icon(
                        Icons.send,
                        size: 30,
                      ),
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
