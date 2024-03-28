import 'package:app/cubit/all_chats_shimmer_status/all_chats_shimmer_status.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/groups/groups_mdeia_fiels/group_get_media_files/group_get_media_files_cubit.dart';
import 'package:app/cubit/groups/groups_mdeia_fiels/group_store_media_files/group_store_media_files_cubit.dart';
import 'package:app/cubit/open_files/open_files_cubit.dart';
import 'package:app/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/cubit/forward/forward_selected_group/forward_selected_group_cubit.dart';
import 'package:app/cubit/groups/delete_groups/delete_groups_cubit.dart';
import 'package:app/cubit/groups/get_groups_member/get_groups_member_cubit.dart';
import 'package:app/cubit/groups/group_permissions/group_permissions_cubit.dart';
import 'package:app/cubit/groups/groups_members_details/groups_members_details_cubit.dart';
import 'package:app/cubit/groups/update_groups_details/update_groups_details_cubit.dart';
import 'package:app/cubit/network_error_status/network_error_status_cubit.dart';
import 'package:app/cubit/update_message_audio_playing/update_message_audio_playing_cubit.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/cubit/upload/upload_file/upload_file_cubit.dart';
import 'package:app/cubit/upload/upload_image/upload_image_cubit.dart';
import 'package:app/cubit/upload/upload_video/upload_video_cubit.dart';
import 'package:app/cubit/auth/register/register_cubit.dart';
import 'package:app/cubit/chats/chats_cubit.dart';
import 'package:app/cubit/follow_status/follow_status_cubit.dart';
import 'package:app/cubit/follower/follower_cubit.dart';
import 'package:app/cubit/forward/forward_selected_friend/forward_selected_friend_cubit.dart';
import 'package:app/cubit/friends/friends_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/groups/create_groups/create_groups_cubit.dart';
import 'package:app/cubit/groups/groups_member_selected/groups_member_selected_cubit.dart';
import 'package:app/cubit/groups/message_group/group_message_cubit.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/pick_contact/pick_contact_cubit.dart';
import 'package:app/cubit/pick_file/pick_file_cubit.dart';
import 'package:app/cubit/pick_image/pick_image_cubit.dart';
import 'package:app/cubit/pick_video/pick_video_cubit.dart';
import 'package:app/cubit/selected_chats/selected_chats_cubit.dart';
import 'package:app/cubit/story/story_cubit.dart';
import 'package:app/cubit/update_user_data/update_user_cubit_cubit.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp(
      {super.key, required this.themeModeService, required this.screen});

  final ThemeModeService themeModeService;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
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
        BlocProvider(create: (context) => GetGroupsMemberCubit()),
        BlocProvider(create: (context) => UpdateGroupsDetailsCubit()),
        BlocProvider(create: (context) => GroupsMembersDetailsCubit()),
        BlocProvider(create: (context) => DeleteGroupsCubit()),
        BlocProvider(create: (context) => AllChatsShimmerStatusCubit()),
        BlocProvider(create: (context) => ConnectivityCubit()),
        BlocProvider(create: (context) => NetworkErrorStatusCubit()),
        BlocProvider(create: (context) => ForwardSelectedGroupCubit()),
        BlocProvider(create: (context) => UploadAudioCubit()),
        BlocProvider(create: (context) => UpdateMessageAudioPlayingCubit()),
        BlocProvider(create: (context) => UploadImageCubit()),
        BlocProvider(create: (context) => UploadVideoCubit()),
        BlocProvider(create: (context) => UploadFileCubit()),
        BlocProvider(create: (context) => GroupPermissionsCubit()),
        BlocProvider(create: (context) => GroupStoreMediaFielsCubit()),
        BlocProvider(create: (context) => GroupGetMediaFilesCubit()),
        BlocProvider(create: (context) => OpenFilesCubit()),
       
      ],
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return GetMaterialApp(
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
