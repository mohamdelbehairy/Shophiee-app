import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
   const CustomBottom(
      {super.key,
      required this.text,
      required this.colorBottom,
      required this.colorText,
      required this.onPressed, this.isLoading = false,this.enableFeedback = true});
  final String text;
  final Color colorBottom;
  final Color colorText;
  final Function() onPressed;
  final bool isLoading;
  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32), color: colorBottom),
      child: MaterialButton(
        enableFeedback: enableFeedback,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        child: isLoading ? SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorText),
          ),
        ) : Text(
          text,
          style: TextStyle(color: colorText),
        ),
      ),
    );
  }
}
