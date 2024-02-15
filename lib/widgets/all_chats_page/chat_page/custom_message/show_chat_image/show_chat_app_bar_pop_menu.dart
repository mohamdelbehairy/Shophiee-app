import 'dart:io';

import 'package:app/models/message_model.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowChatAppBarPopMenu extends StatelessWidget {
  const ShowChatAppBarPopMenu({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    showToastMethod() {
      ShowToast(
          context: context,
          showToastText: 'Saved successfully',
          position: StyledToastPosition.bottom);
    }

    return PopupMenuButton(
      color: Color(0xff2b2c33),
      offset: Offset(0, 50),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: Text('save', style: TextStyle(color: Colors.white)),
            onTap: () async {
              final tempDir = await getTemporaryDirectory();
              final fileName =
                  'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
              final path = '${tempDir.path}/$fileName';
              await Dio().download(message.messageImage!, path);
              await GallerySaver.saveImage(path, albumName: 'Sophiee');
              showToastMethod();
            }),
        PopupMenuItem(
            child: Text('share', style: TextStyle(color: Colors.white)),
            onTap: () async {
              final url = Uri.parse(message.messageImage!);
              final response = await http.get(url);
              final bytes = response.bodyBytes;
              final temp = await getTemporaryDirectory();
              final path = '${temp.path}/image.jpg';
              File(path).writeAsBytesSync(bytes);

              await Share.shareXFiles([XFile(path)]);
            }),
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
