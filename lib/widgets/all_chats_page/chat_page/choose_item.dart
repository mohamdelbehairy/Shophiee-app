import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class CustomChooseItem extends StatelessWidget {
  const CustomChooseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12,left: 12),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: const Color(0xff2b2c33).withOpacity(.1),
        child: Icon(
          Icons.add,
          color: kPrimaryColor,
          size: 30,
        ),
      ),
    );
  }
}
