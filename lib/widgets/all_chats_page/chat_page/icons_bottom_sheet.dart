import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomIconBottomSheet extends StatelessWidget {
  const CustomIconBottomSheet(
      {super.key, required this.icon, required this.color, required this.text});
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white : Colors.black,
          ),
        )
      ],
    );
  }
}
