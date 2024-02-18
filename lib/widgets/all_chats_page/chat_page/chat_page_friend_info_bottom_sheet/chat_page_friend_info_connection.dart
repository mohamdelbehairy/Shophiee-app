import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageFriendInfoConnection extends StatelessWidget {
  const ChatPageFriendInfoConnection(
      {super.key,
      required this.text,
      required this.textInfo,
      required this.iconColor,
      required this.icon});
  final String text;
  final String textInfo;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Text(
                textInfo,
                style: TextStyle(
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: size.height * .02,
            backgroundColor: iconColor,
            child: Icon(icon,
                color: Colors.white, size: size.height * .018),
          )
        ],
      ),
    );
  }
}
