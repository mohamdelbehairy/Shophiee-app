import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowChatMediaAppBarPopMenu extends StatelessWidget {
  const ShowChatMediaAppBarPopMenu(
      {super.key,
     
      required this.saveOnTap,
      required this.shareOnTap
    });
  
  final Function() saveOnTap;
  final Function() shareOnTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopupMenuButton(
      color: kPrimaryColor,
      offset: Offset(0, 50),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: Row(
              children: [
                Icon(FontAwesomeIcons.solidFloppyDisk,
                    size: size.height * .018, color: Colors.white),
                SizedBox(width: size.width * .04),
                Text("Save", style: TextStyle(color: Colors.white)),
              ],
            ),
            onTap: saveOnTap),
        PopupMenuItem(
            child: Row(
              children: [
                Icon(FontAwesomeIcons.share,
                    size: size.height * .018, color: Colors.white),
                SizedBox(width: size.width * .04),
                Text("Share", style: TextStyle(color: Colors.white)),
              ],
            ),
            onTap: shareOnTap),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
        PopupMenuItem(
            child: Text('edit', style: TextStyle(color: Colors.white)),
            onTap: () {}),
      ],
    );
  }
}
