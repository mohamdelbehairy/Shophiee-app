import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/models/group_model.dart';
import 'package:app/widgets/all_chats_page/groups_page/group_image_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddGroups extends StatelessWidget {
  const CustomAddGroups({super.key, required this.groupModel});
  final GroupModel groupModel;

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
              GroupsCoverImage(groupModel: groupModel),
              SizedBox(height: 8),
              Text(
                groupModel.groupName,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
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
