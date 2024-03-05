import 'package:app/models/users_model.dart';
import 'package:app/widgets/profile_page/app_bar_profile.dart';
import 'package:app/widgets/profile_page/card_one_profile/custom_card_one.dart';
import 'package:app/widgets/profile_page/card_three_profile/custom_card_three.dart';
import 'package:app/widgets/profile_page/card_two_profile/custom_card_two.dart';
import 'package:flutter/material.dart';

class CustomProfilePageBody extends StatelessWidget {
  const CustomProfilePageBody(
      {super.key, required this.onTap, required this.user});
  final Function() onTap;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomAppBarProfile(),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      CustomProfileCardOne(
                                          user: user, onTap: onTap),
                                      SizedBox(height: 10),
                                      CustomProfileCardTwo(),
                                      SizedBox(height: 8),
                                      CustomProfileCardThree(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
