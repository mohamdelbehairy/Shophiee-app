import 'package:flutter/material.dart';
import 'package:get/get.dart' as navigation;

class GetNavigation {
  static void getNavigationLeftToRight({required Widget page}) {
    navigation.Get.to(() => page,
        transition: navigation.Transition.leftToRight);
  }
}
