import 'package:flutter/material.dart';

class AddStoryTextField extends StatelessWidget {
  const AddStoryTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.w500,
              ),
              maxLines: null,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: size.height * 0.014),
                hintText: 'Enter Type ....',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withOpacity(0.7),
                    fontSize: size.height * 0.018),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: size.height * 0.15),
        ],
      ),
    );
  }
}
