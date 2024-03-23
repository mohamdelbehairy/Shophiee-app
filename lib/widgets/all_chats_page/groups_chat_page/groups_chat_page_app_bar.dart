import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_state.dart';
import 'package:app/models/group_model.dart';
import 'package:app/pages/chats/groups/groups_chat_page/groups_chat_page_info.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class GroupsChatPageAppBar extends StatelessWidget {
  const GroupsChatPageAppBar({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var isDark = context.read<LoginCubit>().isDark;
    context.read<GetGroupsMemberCubit>().getGroupsMember();
    return BlocBuilder<GetGroupsMemberCubit, GetGroupsMemberState>(
      builder: (context, state) {
        if (state is GetGroupsMemberSuccess && state.groupsList.isNotEmpty) {
          final groupID = groupModel.groupID;
          final groupData = state.groupsList
              .firstWhere((element) => element.groupID == groupID);
          return GestureDetector(
            onTap: () {
              getnav.Get.to(() => GroupsChatPageInfo(groupModel: groupData),
                  transition: getnav.Transition.leftToRight);
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FancyShimmerImage(
                        boxFit: BoxFit.cover,
                        shimmerBaseColor:
                            isDark ? Colors.white12 : Colors.grey.shade300,
                        shimmerHighlightColor:
                            isDark ? Colors.white24 : Colors.grey.shade100,
                        imageUrl: groupData.groupImage!),
                  ),
                ),
                SizedBox(width: size.width * .03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * .45,
                      child: Text(groupData.groupName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white, fontSize: size.width * .04)),
                    ),
                    SizedBox(height: size.width * .005),
                    Text('${groupData.usersID.length} members',
                        style: TextStyle(
                            color: Colors.white70, fontSize: size.width * .03))
                  ],
                ),
              ],
            ),
          );
        } else {
          return Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(groupModel.groupImage!)),
              SizedBox(width: size.width * .03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * .45,
                    child: Text(groupModel.groupName,
                        style: TextStyle(
                            color: Colors.white, fontSize: size.width * .04)),
                  ),
                  Text('${groupModel.usersID.length} members',
                      style: TextStyle(
                          color: Colors.white70, fontSize: size.width * .03))
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
