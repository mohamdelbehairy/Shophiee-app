import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_list_tile.dart';
import 'package:app/widgets/all_chats_page/groups_page/groups_chat_page/groups_high_light_page/groups_high_light_message_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsHighLightListViewItem extends StatelessWidget {
  const GroupsHighLightListViewItem(
      {super.key,
      required this.message,
      required this.size,
      required this.groupModel});

  final MessageModel message;
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = message.senderID;
          final data = state.userModel
              .firstWhere((element) => element.userID == currentUser);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroupsHighLightListTile(
                  message: message,
                  size: size,
                  user: data,
                  groupModel: groupModel),
              GroupsHighLightMessageDateTime(size: size, message: message),
              // Divider()
              Container(
                  height: .3,
                  width: size.width,
                  color: Colors.grey.shade400,
                  margin: EdgeInsets.symmetric(horizontal: size.width * .04)),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
