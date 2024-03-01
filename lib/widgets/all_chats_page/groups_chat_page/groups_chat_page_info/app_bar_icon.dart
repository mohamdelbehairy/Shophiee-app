import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: onTap,
        child: Icon(icon, color: Colors.white, size: size.height * .025));
  }
}
