import 'package:app/models/media_files_model.dart';
import 'package:flutter/material.dart';

class TabBarFilesListTileSubTitle extends StatelessWidget {
  const TabBarFilesListTileSubTitle(
      {super.key, required this.roundedFileSize, required this.mediaFiels});

  final String roundedFileSize;
  final MediaFilesModel mediaFiels;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$roundedFileSize ${mediaFiels.messageFileType} . PDF',
            style: TextStyle(color: Colors.grey)),
        Text(mediaFiels.showTime(), style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
