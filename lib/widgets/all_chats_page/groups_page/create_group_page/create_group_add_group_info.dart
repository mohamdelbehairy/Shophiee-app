import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/create_group_page/create_group_add_group_image.dart';
import 'package:app/widgets/all_chats_page/groups_page/create_group_page/create_group_add_group_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupAddGroupInfo extends StatelessWidget {
  const CreateGroupAddGroupInfo({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var isDark = context.read<LoginCubit>().isDark;
    return Container(
      height: size.height * .12,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 40,
          color: Colors.grey.withOpacity(isDark ? .1 : .3),
        ),
      ]),
      child: Card(
        color: isDark ? Color(0xff2b2c33) : Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: size.width * .025, right: size.width * .05),
          child: Row(
            children: [
              CreateGroupAddGroupImage(),
              SizedBox(width: size.width * .04),
              CreateGroupAddGroupTextField(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
