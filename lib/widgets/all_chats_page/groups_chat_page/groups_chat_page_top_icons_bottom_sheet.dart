import 'package:app/common/navigation.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_pick_image_page.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet/icons_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class GroupsChatPageTopIconsBottomSheet extends StatelessWidget {
  const GroupsChatPageTopIconsBottomSheet({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pickImage = context.read<PickImageCubit>();
    navigation() {
      Navigation.navigationOnePop(context: context);
    }

    return BlocListener<PickImageCubit, PickImageStates>(
      listener: (context, state) {
        if (state is PickImageScucccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupsChatPickImagePage(
                      image: state.image, groupModel: groupModel)));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconBottomSheet(
              onTap: () async {},
              text: 'File',
              color: Colors.indigo,
              icon: Icons.insert_drive_file),
          SizedBox(width: size.width * .08),
          CustomIconBottomSheet(
              onTap: () async {},
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
    );
  }
}
