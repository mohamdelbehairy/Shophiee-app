import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPageListView extends StatelessWidget {
  const FriendsPageListView(
      {super.key, required this.itemCount, required this.friend});
  final int itemCount;
  final List<UserModel> friend;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return Expanded(
      child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyFriendPage(
                            user: friend[index],
                          ))),
              child: ListTile(
                leading: CircleAvatar(
                  radius: size.height * .028,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(friend[index].profileImage),
                ),
                title: Text(
                  friend[index].userName,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
