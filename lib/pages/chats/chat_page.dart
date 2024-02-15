import 'package:app/constants.dart';
import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_body.dart';
import 'package:app/widgets/all_chats_page/chat_page/icon_buttom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: size.width * -.02,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              context.read<ChatsCubit>().chats();
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: BlocBuilder<GetUserDataCubit, GetUserDataStates>(
          builder: (context, state) {
            if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
              final currentUser = user.userID;
              final data = state.userModel
                  .firstWhere((element) => element.userID == currentUser);
              String text;
              int differenceInMinutes = Timestamp.now()
                  .toDate()
                  .difference(data.onlineStatue)
                  .inMinutes;
              int differenceInHours = Timestamp.now()
                  .toDate()
                  .difference(data.onlineStatue)
                  .inHours;
              int differenceInDays =
                  Timestamp.now().toDate().difference(data.onlineStatue).inDays;

              if (differenceInMinutes < 1) {
                text = 'Active Now';
              } else if (differenceInMinutes < 60) {
                if (differenceInMinutes == 1) {
                  text = 'Last Active $differenceInMinutes minute ago';
                } else {
                  text = 'Last Active $differenceInMinutes minutes ago';
                }
              } else if (differenceInHours < 24) {
                if (differenceInHours == 1) {
                  text = 'Last Active $differenceInHours hour ago';
                } else {
                  text = 'Last Active $differenceInHours hours ago';
                }
              } else if (differenceInDays < 7) {
                if (differenceInDays == 1) {
                  text = 'Last Active $differenceInDays day ago';
                } else {
                  text = 'Last Active $differenceInDays days ago';
                }
              } else {
                int weeks = differenceInDays ~/ 7;
                int remainingDays = differenceInDays % 7;
                if (weeks == 1) {
                  text = 'Last Active 1 week ago';
                } else {
                  text = 'Last Active $weeks weeks';
                  if (remainingDays > 0) {
                    text += ' and $remainingDays days';
                  }
                  text += ' ago';
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(data.profileImage),
                      ),
                      SizedBox(width: size.width * .02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.userName,
                            style: TextStyle(
                              fontSize: size.width * .04,
                            ),
                          ),
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: size.width * .02,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        iconTheme: IconThemeData(size: 35, color: Colors.white),
        actions: [
          CustomIconButton(icon: Icons.call),
          CustomIconButton(icon: FontAwesomeIcons.video),
          CustomIconButton(icon: Icons.error),
        ],
      ),
      body: ChatPageBody(user: user),
    );
  }
}
