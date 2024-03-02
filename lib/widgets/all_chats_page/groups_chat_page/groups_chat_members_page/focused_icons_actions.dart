import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/chat_page.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart' as getnav;

class FocusedIconActions extends StatelessWidget {
  const FocusedIconActions(
      {super.key,
      required this.size,
      required this.userData,
      required this.groupModel});
  final Size size;
  final UserModel userData;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      blurBackgroundColor: Colors.transparent,
      openWithTap: true,
      menuOffset: size.height * .025,
      onPressed: () {},
      menuWidth: size.width * .5,
      animateMenuItems: false,
      blurSize: 0,
      menuItemExtent: size.height * .08,
      duration: const Duration(seconds: 0),
      menuItems: [
        CustomMenuItem(
            text: 'Message ${userData.userName.split(' ')[0]}',
            onPressed: () => getnav.Get.to(() => ChatPage(user: userData),
                transition: getnav.Transition.leftToRight)),
        CustomMenuItem(
            text: 'View ${userData.userName.split(' ')[0]}',
            onPressed: () => getnav.Get.to(() => MyFriendPage(user: userData),
                transition: getnav.Transition.leftToRight)),
        if (groupModel.createUserID == FirebaseAuth.instance.currentUser!.uid)
          CustomMenuItem(text: 'Make group admin', onPressed: () {}),
        if (groupModel.createUserID == FirebaseAuth.instance.currentUser!.uid)
          CustomMenuItem(
              text: 'Remove ${userData.userName.split(' ')[0]}',
              onPressed: () {}),
      ],
      child: Icon(FontAwesomeIcons.ellipsisVertical,
          color: Colors.grey, size: size.height * .02),
    );
  }

  FocusedMenuItem CustomMenuItem(
      {required String text, required Function() onPressed}) {
    return FocusedMenuItem(
        backgroundColor: kPrimaryColor,
        title: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: onPressed);
  }
}
