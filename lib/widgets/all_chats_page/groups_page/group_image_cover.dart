import 'package:app/constants.dart';
import 'package:app/models/group_model.dart';
import 'package:flutter/material.dart';

class GroupsCoverImage extends StatelessWidget {
  const GroupsCoverImage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(groupModel.groupImage!),
        ),
        CircleAvatar(
          radius: 8,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 6,
            backgroundColor: kPrimaryColor,
          ),
        )
      ],
    );
  }
}
