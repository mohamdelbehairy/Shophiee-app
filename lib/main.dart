import 'package:app/common/update_user_online.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/auth/register/register_cubit.dart';
import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/follow_status/follow_status_cubit.dart';
import 'package:app/cubit/follower/follower_cubit.dart';
import 'package:app/cubit/forward_selected_friend/forward_selected_friend_cubit.dart';
import 'package:app/cubit/friends/friends_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_scubit.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/cubit/selected_chats/selected_chats_cubit.dart';
import 'package:app/cubit/story/story_cubit.dart';
import 'package:app/cubit/update_user_data/update_user_cubit_cubit.dart';
import 'package:app/firebase_options.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/services/theme.dart';
import 'package:app/simple_observe_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _init();
}

_init() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('userID');
  if (token != null) {
    UpdateUserOnline.checkOnline();
    return runApp(MyApp(screen: HomePage()));
  } else {
    return runApp(MyApp(screen: RegisterPage()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.screen});
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    ThemeModeService themeModeService = ThemeModeService();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => UpdateUserDataCubit()),
        BlocProvider(create: (context) => GetUserDataCubit()..getUserData()),
        BlocProvider(create: (context) => PickImageCubit()),
        // BlocProvider(create: (context) => ThemeCubit()..changeAppTheme()),
        BlocProvider(create: (context) => FollowerCubit()),
        BlocProvider(create: (context) => FollowStatusCubit()),
        BlocProvider(create: (context) => FriendsCubit()),
        BlocProvider(create: (context) => GetFollowingCubit()),
        BlocProvider(create: (context) => GetFollowersCubit()),
        BlocProvider(create: (context) => GetFriendsCubit()),
        BlocProvider(create: (context) => StoryCubit()),
        BlocProvider(create: (context) => PickVideoCubit()),
        BlocProvider(create: (context) => MessageCubit()),
        BlocProvider(create: (context) => ChatsCubit()),
        BlocProvider(create: (context) => PickFileCubit()),
        BlocProvider(create: (context) => PickContactCubit()),
        BlocProvider(create: (context) => ForwardSelectedFriendCubit()),
        BlocProvider(create: (context) => SelectedChatsCubit()),
        BlocProvider(create: (context) => GroupsMemberSelectedCubit()),
        BlocProvider(create: (context) => CreateGroupsCubit()),
        BlocProvider(create: (context) => GroupMessageCubit()),
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeModeService.lightMode(context: context),
            darkTheme: themeModeService.darkMode(context: context),
            themeMode: context.read<LoginCubit>().isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: screen,
          );
        },
      ),
    );
  }
}
