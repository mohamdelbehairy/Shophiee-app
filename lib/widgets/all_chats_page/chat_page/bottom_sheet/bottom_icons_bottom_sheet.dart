import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet/icons_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BottomIconsBottomSheet extends StatelessWidget {
  const BottomIconsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconBottomSheet(
            onTap: () {},
            text: 'Audio',
            color: Colors.orange,
            icon: Icons.headset),
        SizedBox(width: size.width * .08),
        CustomIconBottomSheet(
            onTap: () {},
            text: 'Location',
            color: Colors.pink,
            icon: Icons.location_pin),
        SizedBox(width: size.width * .08),
        CustomIconBottomSheet(
            onTap: () {},
            text: 'Contact',
            color: Colors.blue,
            icon: Icons.person)
      ],
    );
  }
}
