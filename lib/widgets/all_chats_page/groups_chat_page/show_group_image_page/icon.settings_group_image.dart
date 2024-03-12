import 'dart:io';

import 'package:app/models/group_model.dart';
import 'package:app/widgets/show_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class IconSettingsGroupImage extends StatelessWidget {
  const IconSettingsGroupImage(
      {super.key, required this.size, required this.groupModel});

  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    showToastMethod() {
      ShowToast(
          context: context,
          showToastText: 'Image saved successfully',
          position: StyledToastPosition.bottom);
    }

    return Positioned(
      top: size.width * .135,
      right: size.width * .01,
      child: PopupMenuButton(
          color: Colors.white12,
          offset: Offset(10, 50),
          icon: Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.white),
          itemBuilder: (context) => [
                PopupMenuItem(
                    child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                    final tempDir = await getTemporaryDirectory();
                    final fileName =
                        'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
                    final path = '${tempDir.path}/$fileName';
                    await Dio().download(groupModel.groupImage!, path);
                    await GallerySaver.saveImage(path, albumName: 'Sophiee');
                    showToastMethod();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.save,
                          size: size.width * .04, color: Colors.white),
                      SizedBox(width: size.width * .025),
                      Text('Save', style: TextStyle(color: Colors.white))
                    ],
                  ),
                )),
                PopupMenuItem(
                    child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                    final url = Uri.parse(groupModel.groupImage!);
                    final response = await http.get(url);
                    final bytes = response.bodyBytes;
                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.jpg';
                    File(path).writeAsBytesSync(bytes);
                    await Share.shareXFiles([XFile(path)]);
                  },
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.share,
                          size: size.width * .04, color: Colors.white),
                      SizedBox(width: size.width * .025),
                      Text('Share', style: TextStyle(color: Colors.white))
                    ],
                  ),
                )),
              ]),
    );
  }
}
