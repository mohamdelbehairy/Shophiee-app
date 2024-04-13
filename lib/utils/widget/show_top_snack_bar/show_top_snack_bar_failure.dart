import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showTopSnackBarFailure(
    {required BuildContext context,
    required String message,
    int? maxLines,
    Function()? onTap}) {
  return showTopSnackBar(
      Overlay.of(context),
      GestureDetector(
        onTap: onTap,
        child: CustomSnackBar.error(
            maxLines: maxLines ?? 2,
            boxShadow: [BoxShadow(color: Colors.transparent)],
            message: message),
      ));
}
