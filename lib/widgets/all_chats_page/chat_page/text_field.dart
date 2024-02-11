import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField(
      {super.key,
      required this.emojiShow,
      required this.onTap,
      required this.onPressed,
      required this.controller, required this.onChanged});
  final bool emojiShow;
  final Function() onTap;
  final Function() onPressed;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: const Color(0xff2b2c33),
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          maxLines: null,
          onTap: onTap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: const Color(0xff2b2c33).withOpacity(.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                color: const Color(0xff2b2c33).withOpacity(.1),
              ),
            ),
            filled: true,
            fillColor: const Color(0xff2b2c33).withOpacity(.1),
            hintText: 'Type your message',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: IconButton(
              onPressed: onPressed,
              icon: Padding(
                padding: EdgeInsets.only(right: 16, left: 8),
                child: Icon(
                  emojiShow ? Icons.keyboard : Icons.emoji_emotions,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
