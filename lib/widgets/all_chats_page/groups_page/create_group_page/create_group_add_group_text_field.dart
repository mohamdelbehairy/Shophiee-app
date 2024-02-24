import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupAddGroupTextField extends StatelessWidget {
  const CreateGroupAddGroupTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var isDark = context.read<LoginCubit>().isDark;
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'group name is required';
          } else {
            return null;
          }
        },
        controller: controller,
        cursorColor: kPrimaryColor,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          hintText: 'Group name',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
