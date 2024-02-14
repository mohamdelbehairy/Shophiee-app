import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet/bottom_icons_bottom_sheet.dart';
import 'package:app/widgets/all_chats_page/chat_page/bottom_sheet/top_icons_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBottomSheet extends StatelessWidget {
  const ChatBottomSheet({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .3,
      width: size.width * .9,
      child: Card(
        color: isDark ? Colors.black87 : Colors.white,
        margin: EdgeInsets.all(size.width * .065),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * .04),
          child: Column(
            children: [
              TopIconsBottomSheet(user: user),
              SizedBox(height: size.height * .01),
              BottomIconsBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }
}
