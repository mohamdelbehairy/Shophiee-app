import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_fiels/group_get_media_fiels_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsChatMediaFielsPageBody extends StatelessWidget {
  const GroupsChatMediaFielsPageBody(
      {super.key, required this.size, required this.groupModel});
  final Size size;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    var mediaList = context.read<GroupGetMediaFielsCubit>();
    mediaList.getMedia(groupID: groupModel.groupID);
    return SafeArea(
        child: Column(children: [
      Expanded(
          child: TabBarView(children: [
        TabBarMedia(mediaList: mediaList, size: size),
        Text('0'),
        Text('00'),
        Text('0'),
        Text('00')
      ]))
    ]));
  }
}

class TabBarMedia extends StatelessWidget {
  const TabBarMedia({super.key, required this.mediaList, required this.size});
  final GroupGetMediaFielsCubit mediaList;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupGetMediaFielsCubit, GroupGetMediaFielsState>(
      builder: (context, state) {
        if (mediaList.mediaList.isEmpty) {
          return Center(
              child: Text('No Media fiels here yet',
                  style: TextStyle(
                      color: Colors.black, fontSize: size.height * .02)));
        }
        return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: mediaList.mediaList.length,
            itemBuilder: (context, index) {
              if (mediaList.mediaList[index].messageImage != null) {
                return FancyShimmerImage(
                    boxFit: BoxFit.cover,
                    imageUrl: mediaList.mediaList[index].messageImage!);
              }
              if (mediaList.mediaList[index].messageVideo != null) {
                return Text('videooooo');
              }
            });
      },
    );
  }
}
