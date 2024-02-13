import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/friends_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFriendItemOne extends StatelessWidget {
  const MyFriendItemOne({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return Stack(
      children: [
        Container(
          height: size.height * .55,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.white60.withOpacity(.25) : Colors.grey,
                blurRadius: 30,
                offset: Offset(10, 10),
              )
            ],
            image: DecorationImage(
              image: NetworkImage(user.profileImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: size.width * .025,
          top: size.height * .035,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.white),
          ),
        ),
        Positioned(
          left: size.width * .025,
          top: size.height * .035,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FriendsPage()));
            },
            icon: Icon(Icons.arrow_back,
                size: size.height * .035, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
