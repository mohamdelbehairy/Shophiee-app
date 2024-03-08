import 'package:app/constants.dart';
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
      height: size.height * .06,
      width: size.width * .45,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: size.width * .02),
                  CircleAvatar(
                    radius: size.width * .04,
                    backgroundColor: message.senderID ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? Colors.white
                        : kPrimaryColor,
                    child: Icon(Icons.contact_phone,
                        color: message.senderID ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? kPrimaryColor
                            : Colors.white,
                        size: size.width * .045),
                  ),
                  SizedBox(width: size.width * .03),
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
        ],
      ),
    );
  }
}
