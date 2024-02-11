import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class StackItemBottom extends StatelessWidget {
  const StackItemBottom({super.key,this.image = 'https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg'});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Color(0xff2b2c33).withOpacity(.05),
            radius: 25,
            backgroundImage: NetworkImage(image),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 4, end: 4),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              radius: 7,
            ),
          ),
        )
      ],
    );
  }
}
