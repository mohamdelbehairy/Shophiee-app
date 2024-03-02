import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class GroupsChatMembersStatus extends StatelessWidget {
  const GroupsChatMembersStatus({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
              radius: size.height * .008,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: size.height * .006,
                backgroundColor: kPrimaryColor,
              ),
            )
         ;
  }
}