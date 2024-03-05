import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/custom_network_error_message.dart';
import 'package:app/utils/shimmer/home/profile/profile_page_shimmer.dart';
import 'package:app/widgets/profile_page/profile_page_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size  =MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ConnectivityCubit, ConnectivityResult>(
        builder: (context, state) {
          if (state == ConnectivityResult.wifi ||
              state == ConnectivityResult.mobile) {
            return ProfilePageBody();
          } else {
            return Stack(
              children: [
                ProfilePageShimmer(),
                CustomNetWorkErrorMessage(size: size,bottom: size.height * .001)
              ],
            );
          }
        },
      ),
    );
  }
}
