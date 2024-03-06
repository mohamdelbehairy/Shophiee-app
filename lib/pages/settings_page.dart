import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/shimmer/home/settings/settings_page_shimmer.dart';
import 'package:app/widgets/settings/app_bar.dart';
import 'package:app/widgets/settings/card_one.dart';
import 'package:app/widgets/settings/card_two.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ConnectivityCubit,ConnectivityResult>(
        builder: (context,state) {
          if(state == ConnectivityResult.wifi || state == ConnectivityResult.mobile) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  AppBarSettings(),
                  CustomCardOne(),
                  CustomCardTwo(),
                ],
              ),
            );
          } else {
            return SettingsPageShimmer(size: size);
          }
        },

      ),
    );
  }
}
