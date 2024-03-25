import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/message_model.dart';
import 'package:app/utils/widget/messages/custom_message_record_body.dart';
import 'package:app/utils/widget/replay_to_message/replay_record_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMessageRecord extends StatelessWidget {
  const CustomMessageRecord(
      {super.key,
      required this.message,
      required this.size,
      required this.messageTextColor});
  final MessageModel message;
  final Size size;
  final Color messageTextColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = message.senderID;
          final userData = state.userModel
              .firstWhere((element) => element.userID == currentUser);
          return Column(
            children: [
              if (message.replayTextMessage != '' ||
                  message.replayImageMessage != '' ||
                  message.replayFileMessage != '' ||
                  message.replayContactMessage != '')
                ReplayRecordMessage(
                    size: size,
                    message: message,
                    messageTextColor: messageTextColor),
              CustomMessageRecordBody(
                  size: size,
                  message: message,
                  messageTextColor: messageTextColor,
                  user: userData),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
