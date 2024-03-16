import 'package:flutter/material.dart';

class MessageSoundTimrDetails extends StatelessWidget {
  const MessageSoundTimrDetails({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .6,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('data', style: TextStyle(fontSize: size.width * .025)),
            Text('data', style: TextStyle(fontSize: size.width * .025))
          ],
        ),
      ),
    );
  }
}
