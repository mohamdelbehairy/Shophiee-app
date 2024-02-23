import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/pages/chats/create_group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCreateGroup extends StatelessWidget {
  const CustomCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: isDark ? 1 : 40,
          spreadRadius: 0,
          color: isDark ? Colors.transparent : Colors.transparent,
        ),
      ]),
      child: Card(
        color: isDark ? Color(0xff2b2c33) : Colors.white,
        elevation: isDark ? 1 : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateGroupPage())),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.withOpacity(.2),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Create New',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
