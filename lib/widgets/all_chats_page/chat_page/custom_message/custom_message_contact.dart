import 'package:app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomMessageContact extends StatelessWidget {
  const CustomMessageContact({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String formattedPhoneNumber = message.phoneContactNumber!.startsWith('+2')
        ? '+2${message.phoneContactNumber!.substring(2, 3)} ${message.phoneContactNumber!.substring(3, 6)} ${message.phoneContactNumber!.substring(7)}'
        : '+2${message.phoneContactNumber!.substring(0, 1)} ${message.phoneContactNumber!.substring(1, 4)} ${message.phoneContactNumber!.substring(4)}';
    return Container(
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
    );
  }
}
