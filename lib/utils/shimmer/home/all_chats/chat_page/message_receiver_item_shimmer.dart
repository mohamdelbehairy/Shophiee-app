import 'package:app/utils/shimmer/home/profile/custom_item_info_card_one_shimmer.dart';
import 'package:flutter/material.dart';
import 'message_page_custom_meduim_item_shimmmer.dart';

class MessageReceiverItemShimmer extends StatelessWidget {
  const MessageReceiverItemShimmer({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: Column(
            children: [
              CustomMediumItemShimmer(
                  width: 270,
                  alignment: Alignment.centerLeft,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      topRight: Radius.circular(32))),
              const SizedBox(height: 2),
              CustomMediumItemShimmer(
                width: 300,
                alignment: Alignment.centerLeft,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomItemInfoCardOneShimmer(width: size.width / 8),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ],
    );
  }
}
