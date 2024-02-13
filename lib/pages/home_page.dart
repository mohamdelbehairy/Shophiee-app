import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/pages/chats/all_chats_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  final screens = const [
    ProfilePage(),
    AllChatsPage(),
    SettingsPage(),
  ];
  @override
  void initState() {
    super.initState();
    context.read<ChatsCubit>().chats();
    context
        .read<GetFriendsCubit>()
        .getFriends(userID: FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return NavigationBar(
            backgroundColor: context.read<LoginCubit>().isDark
                ? Colors.black26
                : Colors.white10,
            onDestinationSelected: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },
            indicatorColor: Colors.transparent,
            selectedIndex: index,
            destinations: [
              NavigationDestination(
                  selectedIcon: Icon(Icons.person, color: kPrimaryColor),
                  icon: Icon(Icons.person_outline_outlined),
                  label: ''),
              NavigationDestination(
                  selectedIcon:
                      Icon(FontAwesomeIcons.solidComment, color: kPrimaryColor),
                  icon: Icon(FontAwesomeIcons.comment),
                  label: ''),
              NavigationDestination(
                  selectedIcon:
                      Icon(FontAwesomeIcons.gear, color: kPrimaryColor),
                  icon: Icon(Icons.settings_outlined),
                  label: ''),
            ],
          );
        },
      ),
    );
  }
}
