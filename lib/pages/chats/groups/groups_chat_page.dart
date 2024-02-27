import 'package:app/constants.dart';
import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chats_icons_app_bar_button.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_app_bar.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_body.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_pick_items/groups_chat_bottom_sheet_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPage extends StatelessWidget {
  const GroupsChatPage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: GroupsChatPageAppBar(groupModel: groupModel),
        actions: [
          ChatsIconsAppBarButton(icon: Icons.call),
          ChatsIconsAppBarButton(icon: FontAwesomeIcons.video),
          ChatsIconsAppBarButton(icon: Icons.error),
        ],
        leading: GestureDetector(
          onTap: () {
            context.read<PickContactCubit>().emit(PickContactInitial());
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: BlocBuilder<PickContactCubit, PickContactState>(
        builder: (context, state) {
          if (state is PickContactSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => GroupsChatPickContactBottomSheet(
                      groupModel: groupModel,
                      phoneContactName: state.phoneContact.fullName!.toString(),
                      phoneContactNumber:
                          state.phoneContact.phoneNumber!.number.toString()));
            });
          }
          return GroupsChatPageBody(groupModel: groupModel);
        },
      ),
    );
  }
}
