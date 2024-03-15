import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/models/send_message_items_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/send_message/chat_page_choose_media_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ChatPageChooseMedia extends StatelessWidget {
  const ChatPageChooseMedia(
      {super.key, required this.size, required this.user});
  final Size size;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var pickImage = context.read<PickImageCubit>();
    var pickVideo = context.read<PickVideoCubit>();
    var pickFile = context.read<PickFileCubit>();
    var pickContact = context.read<PickContactCubit>();
    List<SendMessageItemdModel> itemsList = [
      SendMessageItemdModel(
        itemName: 'Gallery',
        iconData: Icons.photo_camera,
        backgroundIconColor: Colors.blue,
        iconSize: size.height * .032,
        onPressed: () async {
          await pickImage.pickImage(source: ImageSource.gallery);
        },
      ),
      SendMessageItemdModel(
        itemName: 'Fiels',
        iconData: Icons.attach_file,
        backgroundIconColor: const Color(0xffff1e62),
        onPressed: () async {
          await pickFile.pickFile(allowedExtensions: ['pdf', 'doc']);
        },
      ),
      SendMessageItemdModel(
        itemName: 'Location',
        iconData: Icons.location_on,
        backgroundIconColor: const Color(0xff863af6),
        onPressed: () {},
      ),
      SendMessageItemdModel(
        itemName: 'GIF',
        iconData: Icons.gif,
        iconSize: size.height * .05,
        backgroundIconColor: const Color(0xfffd7730),
        onPressed: () {},
      ),
      SendMessageItemdModel(
        itemName: 'Video',
        iconData: Icons.library_books,
        iconSize: size.height * .035,
        backgroundIconColor: Colors.blue,
        onPressed: () async {
          await pickVideo.pickVideo(source: ImageSource.gallery);
        },
      ),
      SendMessageItemdModel(
        itemName: 'Audio',
        iconData: FontAwesomeIcons.microphone,
        iconSize: 25,
        backgroundIconColor: const Color(0xff22cfa1),
        onPressed: () async {
          await pickFile.pickFile(allowedExtensions: ['mp3']);
        },
      ),
      SendMessageItemdModel(
        itemName: 'Contact',
        iconData: Icons.contact_phone,
        iconSize: 25,
        backgroundIconColor: Colors.purple,
        onPressed: () async {
          await pickContact.pickContact();
        },
      ),
    ];
    return ChatPageChooseMediaListView(size: size, itemsList: itemsList);
  }
}
