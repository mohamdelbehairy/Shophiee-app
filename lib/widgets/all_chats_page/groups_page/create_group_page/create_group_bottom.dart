import 'dart:io';

import 'package:app/constants.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_state.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupBottom extends StatelessWidget {
  const CreateGroupBottom(
      {super.key, required this.globalKey, required this.controller});
  final GlobalKey<FormState> globalKey;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupsMembersSelected = context.read<GroupsMemberSelectedCubit>();
    var createGroup = context.read<CreateGroupsCubit>();
    var selectedImage = context.read<PickImageCubit>();
    return BlocConsumer<CreateGroupsCubit, CreateGroupsState>(
      listener: (context, state) {
        if (state is UploadGroupImageLoading) {
          createGroup.isLoading = state.isLoading;
        }
        if (state is CreateGroupsSuccess) {
          Navigator.pop(context);
          context.read<PickImageCubit>().selectedImage = null;
          for (var friend
              in groupsMembersSelected.getGroupsMemberSelectedFriendsList) {
            groupsMembersSelected.deleteGroupsMemberSelectedFriends(
                selectedFriendID: friend);
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(top: size.height * .02, right: size.width * .015),
          child: GestureDetector(
            onTap: () async {
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();
                final File? selectedImageFile = selectedImage.selectedImage;
                if (selectedImageFile != null) {
                  String groupImageUrl = await createGroup.uploadGroupImage(
                      groupImageFile: selectedImageFile);
                  await createGroup.createGroups(
                    usersID: groupsMembersSelected
                        .getGroupsMemberSelectedFriendsList,
                    groupName: controller.text,
                    groupImageFile: selectedImageFile,
                    groupImageUrl: groupImageUrl,
                  );
                } else {
                  String groupImageUrl =
                      await createGroup.uploadGroupImage(groupImageFile: null);
                  await createGroup.createGroups(
                    usersID: groupsMembersSelected
                        .getGroupsMemberSelectedFriendsList,
                    groupName: controller.text,
                    groupImageFile: null,
                    groupImageUrl: groupImageUrl,
                  );
                }
                controller.clear();
                for (var friend in groupsMembersSelected
                    .getGroupsMemberSelectedFriendsList) {
                  groupsMembersSelected.deleteGroupsMemberSelectedFriends(
                      selectedFriendID: friend);
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: size.height * .04,
                  backgroundColor: kPrimaryColor,
                  child: createGroup.isLoading
                      ? SizedBox(
                          // height: size.height * .037,
                          // width: size.width * .078,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Icon(Icons.done,
                          color: Colors.white, size: size.height * .035),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
