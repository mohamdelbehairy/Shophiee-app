import 'package:app/constants.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/pages/chats/calls_page.dart';
import 'package:app/pages/chats/groups_page.dart';
import 'package:app/pages/friends_page.dart';
import 'package:app/pages/search_page.dart';
import 'package:app/widgets/all_chats_page/all_chats_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int titleIndex = 0;
  List<String> titeles = [
    'All Chat',
    'Group',
    'Calls',
  ];

  @override
  void initState() {
    super.initState();
    context
        .read<GetFollowingCubit>()
        .getFollowing(userID: FirebaseAuth.instance.currentUser!.uid);
    context
        .read<GetFollowersCubit>()
        .getFollowers(userID: FirebaseAuth.instance.currentUser!.uid);

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: titeles.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            titeles[titleIndex],
          ),
          actions: [
            Container(
              height: titleIndex != 0 ? 0 : 48,
              width: titleIndex != 0 ? 0 : 48,
              child: titleIndex != 0
                  ? null
                  : IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendsPage())),
                      icon: Icon(Icons.group),
                    ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage())),
              icon: Icon(Icons.search),
            ),
          ],
          backgroundColor: kPrimaryColor,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Expanded(
                child: TabBar(
                  indicatorColor: Colors.white,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 8),
                  onTap: (index) {
                    titleIndex = index;
                    setState(() {});
                  },
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Text(
                            'Message',
                            style: TextStyle(
                              color: titleIndex == 0
                                  ? Colors.white
                                  : Colors.white60,
                              fontSize: titleIndex == 0
                                  ? size.width * .04
                                  : size.width * .032,
                            ),
                          ),
                          SizedBox(width: 4),
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Group',
                        style: TextStyle(
                          color:
                              titleIndex == 1 ? Colors.white : Colors.white60,
                          fontSize: titleIndex == 1
                              ? size.width * .04
                              : size.width * .032,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Calls',
                        style: TextStyle(
                          color:
                              titleIndex == 2 ? Colors.white : Colors.white60,
                          fontSize: titleIndex == 2
                              ? size.width * .04
                              : size.width * .032,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: Column(
          children: [
            Expanded(
                child: TabBarView(
              children: [
                AllChatsBody(),
                GroupsPage(),
                CallsPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
