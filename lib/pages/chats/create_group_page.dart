import 'package:app/constants.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_scubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/create_group_page/create_group_add_group_info.dart';
import 'package:app/widgets/all_chats_page/groups_page/create_group_page/create_group_bottom.dart';
import 'package:app/widgets/all_chats_page/groups_page/create_group_page/create_group_selected_friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var groupsMembersSelected = context.read<GroupsMemberSelectedCubit>();
    return Scaffold(
        appBar: AppBar(
          titleSpacing: size.width * -.02,
          backgroundColor: kPrimaryColor,
          title: Text('New group',
              style: TextStyle(fontWeight: FontWeight.normal)),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                context.read<PickImageCubit>().selectedImage = null;
                for (var friend in groupsMembersSelected
                    .getGroupsMemberSelectedFriendsList) {
                  groupsMembersSelected.deleteGroupsMemberSelectedFriends(
                      selectedFriendID: friend);
                }
              },
              child: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateGroupAddGroupInfo(controller: controller),
                SizedBox(height: size.height * .002),
                CreateGroupSelectedFriends(),
                CreateGroupBottom(
                  globalKey: globalKey,
                  controller: controller,
                )
              ],
            ),
          ),
        ));
  }
}
