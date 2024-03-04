import 'package:app/cubit/app_status/app_status_cubit.dart';
import 'package:app/utils/shimmer/home/all_chats/list_view_bottom_shimmer.dart';
import 'package:app/utils/shimmer/home/all_chats/list_view_top_shimmer.dart';
import 'package:app/widgets/all_chats_page/list_view_bottom.dart';
import 'package:app/widgets/all_chats_page/list_view_top.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllChatsBody extends StatelessWidget {
  const AllChatsBody({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AppStatusCubit, bool>(
      builder: (BuildContext context, isLoading) {
        return  CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: isLoading ? ListViewTopShimmer(): ListViewTop(),
            ),
            isLoading? SliverToBoxAdapter(child: ListViewBottomShimmer()): ListViewBottom(),
          ],
        );
      },

    );
  }
}
