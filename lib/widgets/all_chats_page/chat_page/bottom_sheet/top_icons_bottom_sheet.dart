import 'package:app/utils/navigation.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_state.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/chats/pick_file_page.dart';
import 'package:app/pages/chats/pick_image_page.dart';
import 'package:app/pages/chats/pick_video_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet/icons_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class TopIconsBottomSheet extends StatelessWidget {
  const TopIconsBottomSheet(
      {super.key,
      required this.user,
      required this.replayTextMessageImage,
      required this.replayImageMessageImage,
      required this.replayFileMessageImage,
      required this.replayContactMessageContact, required this.replayFileMessage});
  final UserModel user;
  final String replayTextMessageImage;
  final String replayImageMessageImage;
  final String replayFileMessageImage;
  final String replayContactMessageContact;
  final String replayFileMessage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pickImage = context.read<PickImageCubit>();
    final pickFile = context.read<PickFileCubit>();
    final pickVideo = context.read<PickVideoCubit>();
    navigation() {
      Navigation.navigationOnePop(context: context);
    }

    return BlocListener<PickImageCubit, PickImageStates>(
      listener: (context, state) {
        if (state is PickImageScucccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PickImagePage(
                      image: state.image,
                      user: user,
                      replayTextMessageImage: replayTextMessageImage,
                      replayImageMessageImage: replayImageMessageImage,
                      replayFileMessageImage: replayFileMessageImage,
                      replayContactMessageContact:
                          replayContactMessageContact)));
        }
      },
      child: BlocListener<PickFileCubit, PickFileState>(
        listener: (context, state) {
          if (state is PickFileSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PickFilePage(
                        file: state.file,
                        user: user,
                        replayTextMessage: replayTextMessageImage,
                        replayImageMessage: replayImageMessageImage,
                        replayFileMessage: replayFileMessage)));
          }
        },
        child: BlocListener<PickVideoCubit, PickVideoState>(
          listener: (context, state) {
            if (state is PickVideoSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PickVideoPage(video: state.video, user: user)));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconBottomSheet(
                  onTap: () async {
                    await pickFile.pickFile();
                    navigation();
                  },
                  text: 'File',
                  color: Colors.indigo,
                  icon: Icons.insert_drive_file),
              SizedBox(width: size.width * .08),
              CustomIconBottomSheet(
                  onTap: () async {
                    await pickVideo.pickVideo(source: ImageSource.gallery);
                    pickVideo.selectedVideo = null;
                    navigation();
                  },
                  text: 'Video',
                  color: Colors.pink,
                  icon: Icons.collections),
              SizedBox(width: size.width * .08),
              CustomIconBottomSheet(
                  onTap: () async {
                    await pickImage.pickImage(source: ImageSource.gallery);
                    navigation();
                  },
                  text: 'Gallery',
                  color: Colors.purple,
                  icon: Icons.insert_photo)
            ],
          ),
        ),
      ),
    );
  }
}
