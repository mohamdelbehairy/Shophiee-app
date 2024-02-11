import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

Future<Widget?> ShowToast(
    {required BuildContext context,
    required String showToastText,
    required StyledToastPosition position,
    Color color = kPrimaryColor}) async {
  showToast(
    backgroundColor: color,
    showToastText,
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    position: position,
    reverseAnimation: StyledToastAnimation.fade,
    animDuration: Duration(seconds: 1),
    duration: Duration(seconds: 2),
    animation: StyledToastAnimation.scale,
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
    context: context,
  );
  return null;
}
