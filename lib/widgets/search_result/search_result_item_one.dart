import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchResultItemOne extends StatefulWidget {
  const SearchResultItemOne({super.key, required this.user});
  final UserModel user;

  @override
  State<SearchResultItemOne> createState() => _SearchResultItemOneState();
}

class _SearchResultItemOneState extends State<SearchResultItemOne> {
  void init() {
    context
        .read<GetFriendsCubit>()
        .getFriends(userID: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;

    return Stack(
      children: [
        Container(
          height: size.height * .55,
          width: size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.white60.withOpacity(.25) : Colors.grey,
                blurRadius: 30,
                offset: Offset(10, 10),
              )
            ],
            image: DecorationImage(
                image: NetworkImage(widget.user.profileImage),
                fit: BoxFit.fitHeight),
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
                init();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,
                  size: size.height * .035, color: Colors.white)),
        ),
      ],
    );
  }
}
