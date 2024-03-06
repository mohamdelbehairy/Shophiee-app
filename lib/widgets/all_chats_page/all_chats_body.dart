import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/shimmer/home/all_chats/chats/list_view_bottom_shimmer.dart';
import 'package:app/utils/shimmer/home/all_chats/chats/list_view_top_shimmer.dart';
import 'package:app/widgets/all_chats_page/list_view_bottom.dart';
import 'package:app/widgets/all_chats_page/list_view_top.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityResult>(
        builder: (context, state) {
      if (state == ConnectivityResult.wifi ||
          state == ConnectivityResult.mobile) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListViewTop(),
            ),
            ListViewBottom(),
          ],
        );
      } else {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   showTopSnackBar(Overlay.of(context),
        //       snackBarPosition: SnackBarPosition.bottom,
        //       CustomSnackBar.error(message: 'Please check your internet connection and try again.'));
        // });
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(children: [
            ListViewTopShimmer(),
            ListViewBottomShimmer(),
          ]),
        );
      }
    });
  }
}
