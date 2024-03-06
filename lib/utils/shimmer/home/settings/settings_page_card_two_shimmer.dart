import 'package:app/utils/shimmer/home/profile/custom_item_info_card_one_shimmer.dart';
import 'package:app/utils/shimmer/home/settings/settings_page_card_one_item_shimmer.dart';
import 'package:app/utils/shimmer/home/settings/settings_page_card_two_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SettingsPageCardTwoShimmer extends StatelessWidget {
  const SettingsPageCardTwoShimmer(
      {super.key, required this.isDark, required this.size});
  final bool isDark;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Container(
        height: 155,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: isDark
                ? Colors.grey.withOpacity(.1)
                : Colors.grey.withOpacity(.4),
            // spreadRadius: 10,
            // offset: Offset(10, 10),
          )
        ]),
        child: Card(
          color: isDark ? Color(0xff2b2c33) : Colors.white,
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: isDark ? Colors.white12 : Colors.grey.shade300,
              highlightColor: isDark ? Colors.white24 : Colors.grey.shade100,
              child: Column(
                children: [
                  SettingsPageCardTwoItemShimmer(size:size),
                  SizedBox(height: 22),
                  SettingsPageCardOneItemShimmer(size: size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
