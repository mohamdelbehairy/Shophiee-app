import 'package:flutter/material.dart';

class ChatsIconsAppBarButton extends StatelessWidget {
  const ChatsIconsAppBarButton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4, left: 6),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Icon(
          icon,
          size: 25,
        ),
      ),
    );
  }
}
