import 'package:flutter/material.dart';

class CustomIconBottomSheet extends StatelessWidget {
  const CustomIconBottomSheet(
      {super.key, required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(text,style: TextStyle(fontSize: 12,),)
      ],
    );
  }
}
