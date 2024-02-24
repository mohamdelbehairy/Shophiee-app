import 'package:app/models/group_model.dart';
import 'package:flutter/material.dart';

class GroupsChatPageAppBar extends StatelessWidget {
  const GroupsChatPageAppBar({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(groupModel.groupImage!),
            ),
            SizedBox(width: size.width * .02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groupModel.groupName,
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * .04)),
                Text('Active now',
                    style: TextStyle(
                        color: Colors.white, fontSize: size.width * .02)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
