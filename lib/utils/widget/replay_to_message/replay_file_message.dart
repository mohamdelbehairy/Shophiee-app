import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReplayFileMessage extends StatelessWidget {
  const ReplayFileMessage(
      {super.key,
      required this.messageModel,
      this.user,
      required this.onTap,
      this.groupModel});
  final MessageModel messageModel;
  final UserModel? user;
  final GroupModel? groupModel;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * .012),
      child: Container(
        height: size.height * .06,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(size.height * .04)),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.height * .02),
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: size.height * .02),
                            child: Icon(FontAwesomeIcons.sliders,
                                color: Colors.white, size: size.height * .012)),
                        Icon(FontAwesomeIcons.reply,
                            color: Colors.white, size: size.height * .025),
                      ],
                    ),
                    SizedBox(width: size.width * .03),
                    Container(
                      // height: size.height * .04,
                      width: size.height * .04,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.insert_drive_file,
                            color: kPrimaryColor, size: size.width * .05),
                      ),
                    ),
                    SizedBox(width: size.width * .03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * .005),
                            child: Text(
                                'Reply to ${user != null ? user!.userName : groupModel!.groupName}')),
                        SizedBox(
                          width: size.width * .55,
                          child: Text(
                            messageModel.messageFileName!,
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: size.height * .014),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(FontAwesomeIcons.xmark, color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
