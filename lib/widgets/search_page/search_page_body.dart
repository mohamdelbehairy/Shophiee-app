import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_cubit.dart';
import 'package:app/cubit/get_friends/get_friends_state.dart';
import 'package:app/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/get_user_data/get_user_data_state.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/search_result.dart';
import 'package:app/widgets/search_page/no_result_found.dart';
import 'package:app/widgets/search_page/result_item.dart';
import 'package:app/widgets/settings/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({super.key});

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  TextEditingController controller = TextEditingController();
  List<UserModel> list = [];
  List<UserModel> searchList = [];

  @override
  void initState() {
    super.initState();
    context.read<GetFriendsCubit>().emit(GetFriendsInitial());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
        builder: (context, state) {
      if (state is GetUserDataSuccess) {
        list = state.userModel;
        return Column(
          children: [
            Stack(
              children: [
                CustomAppBarSetting(
                  controller: controller,
                  onTap: () {
                    setState(() {
                      controller.clear();
                      searchList.clear();
                    });
                  },
                  hintText: 'Search Friends',
                  suffixIcon: controller.text.isNotEmpty ? Icons.close : null,
                  onChanged: (value) {
                    setState(() {
                      searchList = value.isEmpty
                          ? []
                          : list
                              .where((element) =>
                                  (element.userName
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.emailAddress
                                          .toLowerCase()
                                          .contains(value.toLowerCase())) &&
                                  element.userID !=
                                      FirebaseAuth.instance.currentUser!.uid)
                              .toList();
                    });
                  },
                  widget:
                      Icon(FontAwesomeIcons.barsStaggered, color: Colors.white),
                  appParTitle: 'Search',
                  padding: EdgeInsets.only(left: size.height * .035),
                ),
                Positioned(
                  left: 0.0,
                  top: size.height * .045,
                  child: IconButton(
                    color: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      context.read<GetFollowingCubit>().getFollowing();
                      context.read<GetFollowersCubit>().getFollowers();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: size.height * .035,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * .04,
                  right: size.width * .04,
                  top: size.width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Search',
                    style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.grey,
                        fontSize: size.width * .04),
                  ),
                  Text(
                    'Clear History',
                    style: TextStyle(
                        color: Colors.blue, fontSize: size.width * .04),
                  ),
                ],
              ),
            ),
            Expanded(
              child: searchList.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResultPage(
                                        user: searchList[index]))),
                            child: ResultIem(user: searchList[index]));
                      })
                  : list
                          .where((element) => (element.emailAddress
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase()) ||
                              element.userName
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase())))
                          .toList()
                          .isEmpty
                      ? CustomNoResultFound()
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/search_friends.png'),
                            ),
                          ),
                        ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
