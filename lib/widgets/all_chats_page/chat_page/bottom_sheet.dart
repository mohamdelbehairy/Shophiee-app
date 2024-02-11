import 'package:app/widgets/all_chats_page/chat_page/icons_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconBottomSheet(
                      text: 'Document',
                      color: Colors.indigo,
                      icon: Icons.insert_drive_file),
                  SizedBox(width: 40),
                  CustomIconBottomSheet(
                      text: 'Camera',
                      color: Colors.pink,
                      icon: Icons.camera_alt),
                  SizedBox(width: 40),
                  CustomIconBottomSheet(
                      text: 'Gallery',
                      color: Colors.purple,
                      icon: Icons.insert_photo)
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconBottomSheet(
                      text: 'Audio', color: Colors.orange, icon: Icons.headset),
                  SizedBox(width: 40),
                  CustomIconBottomSheet(
                      text: 'Location',
                      color: Colors.pink,
                      icon: Icons.location_pin),
                  SizedBox(width: 40),
                  CustomIconBottomSheet(
                      text: 'Contact', color: Colors.blue, icon: Icons.person)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
