import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class ChatPageFriendInfoBottom extends StatelessWidget {
  const ChatPageFriendInfoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .045,
      width: size.width * .2,
      margin: EdgeInsets.only(right: size.width * .04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * .04),
        color: kPrimaryColor,
        border: Border.all(color: Colors.transparent),
      ),
      child: Center(
        child: Text(
          'Follow',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
