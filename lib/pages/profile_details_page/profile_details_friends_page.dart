import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:app/widgets/profile_details_page/tab_bar_items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class ProfileDetailsFriendsPage extends StatelessWidget {
  const ProfileDetailsFriendsPage({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFriendsCubit, GetFriendsState>(
      builder: (context, state) {
        if (state is GetFriendsSuccess) {
          return ListView.builder(
              itemCount: state.friends.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    getnav.Get.to(
                        () => MyFriendPage(user: state.friends[index]),
                        transition: getnav.Transition.leftToRight);
                  },
                  child: TabBarItemsListTile(
                      user: state.friends[index], size: size),
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
