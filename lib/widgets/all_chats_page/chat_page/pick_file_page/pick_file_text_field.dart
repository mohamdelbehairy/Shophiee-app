import 'package:flutter/material.dart';

class PickFileTextField extends StatelessWidget {
  const PickFileTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      color: Color(0xff000101),
      padding: EdgeInsets.only(top: size.height *.015),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height *.025),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xff1e2c32),
              contentPadding: EdgeInsets.symmetric(horizontal: size.height *.025),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(size.height *.032),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(size.height *.032),
              ),
              hintText: 'Add a caption...',
              hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }
}
