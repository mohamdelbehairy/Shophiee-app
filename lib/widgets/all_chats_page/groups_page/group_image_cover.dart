import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class GroupsCoverImage extends StatelessWidget {
  const GroupsCoverImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/home1.jpg'),
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
