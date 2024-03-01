import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_state.dart';
import 'package:app/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GroupsChatEditImage extends StatelessWidget {
  const GroupsChatEditImage({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var selectedImage = context.read<PickImageCubit>().selectedImage;

    return BlocConsumer<PickImageCubit, PickImageStates>(
      listener: (context, state) {
        if (state is PickImageScucccess) {
          selectedImage = state.image;
        }
      },
      builder: (context, state) {
        if (state is PickImageScucccess) {
          print(state.image);
          return CircleAvatar(
              radius: size.height * .04,
              backgroundColor: Colors.transparent,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!)
                  : NetworkImage(groupModel.groupImage!) as ImageProvider);
        } else {
          return CircleAvatar(
              radius: size.height * .04,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(groupModel.groupImage!));
        }
      },
    );
  }
}
