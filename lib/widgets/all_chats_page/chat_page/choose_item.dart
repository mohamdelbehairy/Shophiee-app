import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class CustomChooseItem extends StatelessWidget {
  const CustomChooseItem({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: CircleAvatar(
        radius: 26,
        backgroundColor: const Color(0xff2b2c33).withOpacity(.03),
        child: Icon(
          icon,
          color: kPrimaryColor,
          size: 30,
        ),
      ),
    );
  }
}
