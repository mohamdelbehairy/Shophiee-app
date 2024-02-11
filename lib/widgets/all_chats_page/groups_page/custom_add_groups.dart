import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/widgets/all_chats_page/groups_page/group_image_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddGroups extends StatelessWidget {
  const CustomAddGroups({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    List images = [
      'assets/images/home1.jpg',
      'assets/images/home3.jpg',
      'assets/images/home4.jpg',
      'assets/images/signPage.jpg',
    ];
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
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(FontAwesomeIcons.ellipsisVertical),
                ],
              ),
              GroupsCoverImage(),
              SizedBox(height: 8),
              Text(
                'Friends & Family',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < images.length; i++)
                    Align(
                      widthFactor: 0.5,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(images[i]),
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
