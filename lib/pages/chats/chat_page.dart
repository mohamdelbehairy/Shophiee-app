import 'package:app/constants.dart';
import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_app_bar_title.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_body.dart';
import 'package:app/widgets/all_chats_page/chat_page/icon_buttom.dart';
import 'package:app/widgets/all_chats_page/chat_page/pick_contact_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              context.read<PickContactCubit>().emit(PickContactInitial());
              context.read<GetFollowersCubit>().getFollowers(userID: FirebaseAuth.instance.currentUser!.uid);
              context.read<GetFollowingCubit>().getFollowing(userID: FirebaseAuth.instance.currentUser!.uid);
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,size: size.height *.04)),
        title: ChatPageAppBatTitle(user: user),


        iconTheme: IconThemeData(size: 35, color: Colors.white),
        actions: [
          CustomIconButton(icon: Icons.call),
          CustomIconButton(icon: FontAwesomeIcons.video),
          CustomIconButton(icon: Icons.error),
        ],
      ),
      body: BlocBuilder<PickContactCubit, PickContactState>(
        builder: (context, state) {
          if (state is PickContactSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => PickContactBottomSheet(
                    user: user,
                    phoneContactName: state.phoneContact.fullName!.toString(),
                    phoneContactNumber:
                        state.phoneContact.phoneNumber!.number.toString()),
              );
            });
          }
          return ChatPageBody(user: user);
        },
      ),
    );
  }
}
