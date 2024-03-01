import 'package:app/cubit/groups/update_groups_details/update_groups_details_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_chat_page/groups_chat_page_info/app_bar_icon.dart';
import 'package:flutter/material.dart';

class EditingGroupsDetails extends StatelessWidget {
  const EditingGroupsDetails(
      {super.key,
      required this.size,
      required this.updateGroupName,
      required this.groupModel,
      required this.controller,
      required this.selectedImage});

  final Size size;
  final UpdateGroupsDetailsCubit updateGroupName;
  final GroupModel groupModel;
  final TextEditingController controller;
  final PickImageCubit selectedImage;

  @override
  Widget build(BuildContext context) {
    return AppBarIcon(
        icon: Icons.done,
        padding: size.width * .04,
        iconsSize: size.height * .03,
        onTap: () async {
          if (controller.text != groupModel.groupName) {
            await updateGroupName.updateGroupName(
                groupID: groupModel.groupID, newGroupName: controller.text);
          }

          if (selectedImage.selectedImage != null) {
            await updateGroupName.updateGroupImage(
                groupID: groupModel.groupID,
                groupImageFile: selectedImage.selectedImage!);
            print('selectedImage: ${selectedImage.selectedImage}');
            selectedImage.selectedImage = null;
          }
        });
  }
}
