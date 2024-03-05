import 'package:app/cubit/all_chats_shimmer_status/all_chats_shimmer_status.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/utils/custom_network_error_message.dart';
import 'package:app/utils/shimmer/home/all_chats/chats/list_view_bottom_shimmer.dart';
import 'package:app/utils/shimmer/home/all_chats/chats/list_view_top_shimmer.dart';
import 'package:app/widgets/all_chats_page/list_view_bottom.dart';
import 'package:app/widgets/all_chats_page/list_view_top.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AllChatsShimmerStatusCubit, bool>(
      builder: (BuildContext context, isLoading) {
        return BlocBuilder<ConnectivityCubit, ConnectivityResult>(
            builder: (context, state) {
          if (state == ConnectivityResult.wifi ||
              state == ConnectivityResult.mobile) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: isLoading ? ListViewTopShimmer() : ListViewTop(),
                ),
                isLoading
                    ? SliverToBoxAdapter(child: ListViewBottomShimmer())
                    : ListViewBottom(),
              ],
            );
          } else {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Column(children: [
                    ListViewTopShimmer(),
                    ListViewBottomShimmer()
                  ]),
                  CustomNetWorkErrorMessage(size: size)
                ],
              ),
            );
          }
        });
      },
    );
  }
}
