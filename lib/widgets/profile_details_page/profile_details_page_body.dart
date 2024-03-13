import 'package:app/constants.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/profile_details_page/followers_page.dart';
import 'package:app/pages/profile_details_page/followings_page.dart';
import 'package:app/widgets/profile_details_page/custom_tab_bar_item.dart';
import 'package:app/widgets/profile_details_page/profile_details_page_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPageBody extends StatefulWidget {
  const ProfileDetailsPageBody(
      {super.key, required this.size, required this.user});

  final Size size;
  final UserModel user;

  @override
  State<ProfileDetailsPageBody> createState() => _ProfileDetailsPageBodyState();
}

class _ProfileDetailsPageBodyState extends State<ProfileDetailsPageBody> {
  int titleIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: widget.size.width * -.02,
          backgroundColor: kPrimaryColor,
          title: ProfileDetailsPageAppBar(user: widget.user, size: widget.size),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Expanded(
                  child: TabBar(
                      indicatorColor: Colors.white,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
                      onTap: (index) {
                        setState(() {
                          titleIndex = index;
                        });
                      },
                      tabs: [
                    CustomTabBarItem(
                        titleIndex: titleIndex,
                        size: widget.size,
                        tabBarText: 'Followers',
                        tabBarColor:
                            titleIndex == 0 ? Colors.white : Colors.white60,
                        tabBarTextSize: titleIndex == 0
                            ? widget.size.width * .035
                            : widget.size.width * .03),
                    CustomTabBarItem(
                        titleIndex: titleIndex,
                        size: widget.size,
                        tabBarText: 'Followings',
                        tabBarColor:
                            titleIndex == 1 ? Colors.white : Colors.white60,
                        tabBarTextSize: titleIndex == 1
                            ? widget.size.width * .035
                            : widget.size.width * .03),
                    CustomTabBarItem(
                        titleIndex: titleIndex,
                        size: widget.size,
                        tabBarText: 'Friends',
                        tabBarColor:
                            titleIndex == 2 ? Colors.white : Colors.white60,
                        tabBarTextSize: titleIndex == 2
                            ? widget.size.width * .035
                            : widget.size.width * .03),
                  ]))),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: TabBarView(children: [
                FollowersPage(),
                FollowingsPage(),
                FollowingsPage()
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
