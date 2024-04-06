import 'package:app/constants.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/chat_media_files_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getnav;

class ChatPageFriendInfoBottomSheetDetails extends StatelessWidget {
  const ChatPageFriendInfoBottomSheetDetails(
      {super.key, required this.size, required this.user});
  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.width * .06),
      child: Column(
        children: [
          ChatPageFriendInfoBottomSheet(
              onTap: () {},
              text: 'Contact Info',
              textInfo: 'Mohamed.myself@gmail.com',
              iconColor: Colors.blue,
              icon: Icons.email),
          SizedBox(height: size.height * .01),
          ChatPageFriendInfoBottomSheet(
              onTap: () {},
              text: 'Phone Call',
              textInfo: '+20 111 5555 555',
              iconColor: kPrimaryColor,
              icon: Icons.call),
          SizedBox(height: size.height * .01),
          ChatPageFriendInfoBottomSheet(
              text: 'Media files',
              iconColor: Colors.blue,
              icon: Icons.perm_media,
              onTap: () => getnav.Get.to(
                  () => ChatMediaFilesPage(size: size, user: user),
                  transition: getnav.Transition.leftToRight)),
          SizedBox(height: size.height * .01),
          ChatPageFriendInfoBottomSheet(
              text: 'Highlights',
              iconColor: kPrimaryColor,
              icon: Icons.star,
              onTap: () {}),
        ],
      ),
    );
  }
}
