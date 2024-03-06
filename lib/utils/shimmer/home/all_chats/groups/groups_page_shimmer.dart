import 'package:app/utils/shimmer/home/profile/custom_item_info_card_one_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class GroupsChatShimmer extends StatelessWidget {
  const GroupsChatShimmer(
      {super.key, required this.isDark, required this.size});
  final bool isDark;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .9,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: isDark ? 1 : 40,
                  spreadRadius: 0,
                  color: isDark ? Colors.transparent : Colors.transparent,
                )
              ]),
              child: Card(
                  color: isDark ? Color(0xff2b2c33) : Colors.white,
                  elevation: isDark ? 1 : 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                    child: Shimmer.fromColors(
                      baseColor: isDark ? Colors.white12 : Colors.grey.shade300,
                      highlightColor:
                          isDark ? Colors.white24 : Colors.grey.shade100,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              Icon(FontAwesomeIcons.ellipsisVertical)
                            ],
                          ),
                          Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          SizedBox(height: 8),
                          CustomItemInfoCardOneShimmer(width: size.width / 4),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < 4; i++)
                                Align(
                                  widthFactor: 0.5,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)
                                    ),
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
