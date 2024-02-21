import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBottomListTileTitle extends StatelessWidget {
  const ItemBottomListTileTitle({super.key, required this.data, required this.user});
  final UserModel data;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              data.userName,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(width: size.width * .02),
            if (user.lastMessage?['senderID'] !=
                    FirebaseAuth.instance.currentUser!.uid &&
                !user.lastMessage?['isSeen'])
              Padding(
                padding: EdgeInsets.only(top: size.width * .012),
                child: CircleAvatar(
                  radius: size.width * .014,
                  backgroundColor: kPrimaryColor,
                ),
              )
          ],
        ),
        Text(
          user.formattedTime(),
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: size.width * .03),
        )
      ],
    );
  }
}
