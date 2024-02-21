import 'package:app/constants.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/all_chats_page/item_bottom_list_tile_sub_title.dart';
import 'package:app/widgets/all_chats_page/item_bottom_list_tile_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBottom extends StatelessWidget {
  const ItemBottom({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color color;
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = user.userID;
          final data = state.userModel
              .firstWhere((element) => element.userID == currentUser);
          int differenceInMinutes =
              Timestamp.now().toDate().difference(data.onlineStatue).inMinutes;
          if (differenceInMinutes < 1) {
            color = kPrimaryColor;
          } else {
            color = Colors.grey;
          }
          return ListTile(
            title: ItemBottomListTileTitle(data:data,user: user),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: size.width * .069,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(data.profileImage),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: CircleAvatar(
                    radius: size.width * .022,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: size.width * .017,
                    ),
                  ),
                )
              ],
            ),
            subtitle: ItemBottomSubTitleListTile(user: user, data: data),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
