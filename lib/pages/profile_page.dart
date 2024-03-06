import 'package:app/cubit/all_chats_shimmer_status/all_chats_shimmer_status.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/shimmer/home/profile/profile_page_shimmer.dart';
import 'package:app/widgets/profile_page/profile_page_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllChatsShimmerStatusCubit, bool>(
        builder: (context, isLoading) {
          return BlocBuilder<ConnectivityCubit, ConnectivityResult>(
            builder: (context, state) {
              if (state == ConnectivityResult.wifi ||
                  state == ConnectivityResult.mobile) {
                return isLoading ? ProfilePageShimmer() : ProfilePageBody();
              } else {
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //
                //   showTopSnackBar(Overlay.of(context),
                //       snackBarPosition: SnackBarPosition.bottom,
                //       CustomSnackBar.error(message: 'Please check your internet connection and try again.'));
                // });
                return ProfilePageShimmer();
              }
            },
          );
        },
      ),
    );
  }
}
