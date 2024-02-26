import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupsChatCustomMessageContact extends StatelessWidget {
  const GroupsChatCustomMessageContact({super.key, required this.message, required this.user});
  final MessageModel message;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String formattedPhoneNumber = message.phoneContactNumber!.startsWith('+2')
        ? '+2${message.phoneContactNumber!.substring(2, 3)} ${message.phoneContactNumber!.substring(3, 6)} ${message.phoneContactNumber!.substring(7)}'
        : '+2${message.phoneContactNumber!.substring(0, 1)} ${message.phoneContactNumber!.substring(1, 4)} ${message.phoneContactNumber!.substring(4)}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.senderID != FirebaseAuth.instance.currentUser!.uid &&
            message.phoneContactNumber != null)
          Text(user.userName,
              style: TextStyle(
                  fontSize: size.width * .04,
                  color: Colors.blue,
                  fontWeight: FontWeight.normal)),
        Container(
          height: size.height * .12,
          width: size.width * .6,
          child: Card(
            color: Colors.grey.withOpacity(.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * .01)),
            child: Row(
              children: [
                Container(
                  width: size.width * .008,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * .2),
                      bottomLeft: Radius.circular(size.width * .1),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: size.width * .05),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.phoneContactName!,
                                  style: TextStyle(
                                      color: message.senderID ==
                                          FirebaseAuth.instance.currentUser!.uid
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  formattedPhoneNumber,
                                  style: TextStyle(
                                      color: message.senderID ==
                                          FirebaseAuth.instance.currentUser!.uid
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: size.width * .013, left: size.width * .03),
                      height: .2,
                      width: size.width * .5,
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * .01),
                    Text('Contact',
                        style: TextStyle(
                            color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                                ? Colors.white
                                : Colors.black))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
