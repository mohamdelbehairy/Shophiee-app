import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupChatMessageTextField extends StatelessWidget {
  const GroupChatMessageTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.onPressed});
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: SizedBox(
        width: size.width,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: const Color(0xff2b2c33),
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: size.width * .035),
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * .04),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * .08),
              borderSide: BorderSide(
                color: const Color(0xff2b2c33).withOpacity(.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.width * .08),
              borderSide: BorderSide(
                color: const Color(0xff2b2c33).withOpacity(.1),
              ),
            ),
            filled: true,
            fillColor: const Color(0xff2b2c33).withOpacity(.1),
            hintText: 'Type your message',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onPressed,
              icon: Padding(
                padding: EdgeInsets.only(
                    right: size.width * .04, left: size.width * .02),
                child: Icon(
                  FontAwesomeIcons.paperclip,
                  color: kPrimaryColor,
                  size: size.width * .05,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
