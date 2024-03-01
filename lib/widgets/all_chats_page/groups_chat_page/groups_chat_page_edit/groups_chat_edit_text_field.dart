import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class GroupsChatEditTextField extends StatelessWidget {
  const GroupsChatEditTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: size.height * .03),
        child: TextField(
        controller: controller,
          cursorColor: kPrimaryColor,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'group name',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: kPrimaryColor, width: size.width * .008)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: kPrimaryColor, width: size.width * .008))),
        ),
      ),
    );
  }
}
