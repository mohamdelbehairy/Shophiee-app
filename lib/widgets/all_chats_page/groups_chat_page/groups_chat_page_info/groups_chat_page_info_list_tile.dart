import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:flutter/material.dart';

class GroupsChatPageInfoListTile extends StatelessWidget {
  const GroupsChatPageInfoListTile({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: CircleAvatar(
          radius: size.height * .035,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(groupModel.groupImage!)),
      title: Row(
        children: [
          Text(groupModel.groupName),
          SizedBox(width: size.width * .02),
          Icon(Icons.edit, color: Colors.grey, size: size.height * .025)
        ],
      ),
      subtitle: Row(
        children: [
          CircleAvatar(
            radius: size.height * .005,
            backgroundColor: kPrimaryColor,
          ),
          SizedBox(width: size.width * .015),
          Text('Active Now')
        ],
      ),
    );
  }
}
