import 'package:app/cubit/auth/login/login_cubit.dart';
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
          color: isDark
              ? Colors.transparent
              : Colors.transparent,
        ),
      ]),
      child: Card(
        color: isDark
            ? Color(0xff2b2c33)
            : Colors.white,
        elevation: isDark ? 1 : 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              // backgroundColor: Colors.grey.withOpacity(.4),
              child: Icon(
                Icons.add,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Create New',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
