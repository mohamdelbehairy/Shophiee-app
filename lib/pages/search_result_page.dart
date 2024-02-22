import 'package:app/constants.dart';
import 'package:app/cubit/follow_status/follow_status_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/widgets/search_result/search_result_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context
        .read<FollowStatusCubit>()
        .checkFollowStatus(followerID: user.userID);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        titleSpacing: size.width * -.02,
        title: Text('Search Page',
            style: TextStyle(
                fontSize: size.height * .028, fontWeight: FontWeight.bold)),
      ),
      body: SearchResultBogy(user: user),
    );
  }
}
