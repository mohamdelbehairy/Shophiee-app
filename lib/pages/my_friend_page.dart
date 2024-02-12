import 'package:app/models/users_model.dart';
import 'package:app/widgets/my_friend_page/my_friend_item_one.dart';
import 'package:app/widgets/my_friend_page/my_friends_bottom_send_message.dart';
import 'package:app/widgets/search_result/search_result_item_bio.dart';
import 'package:app/widgets/search_result/search_result_item_last.dart';
import 'package:app/widgets/search_result/search_result_item_two.dart';
import 'package:app/widgets/search_result/search_result_list_view.dart';
import 'package:flutter/material.dart';

class MyFriendPage extends StatelessWidget {
  const MyFriendPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            MyFriendItemOne(user: user),
            SearchResultItemTwo(
              user: user,
              widget: MyFriendsBottomMessage(user: user),
            ),
            SizedBox(height: size.height * .007),
            SearchResultItemLast(
                text: user.userName.split(' ')[0],
                textButton: 'More',
                onTap: () {}),
            SizedBox(height: size.height * .02),
            SearchResultItemBio(user: user),
            SizedBox(height: size.height * .026),
            SearchResultItemLast(
                text: 'Friends', textButton: 'See all', onTap: () {}),
            SizedBox(height: size.height * .004),
            SearchResultListView(friend: user),
            SizedBox(height: size.height * .02),
            SearchResultItemLast(
                text: 'Photos', textButton: 'See all', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
