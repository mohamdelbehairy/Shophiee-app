import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBarProfile extends StatelessWidget {
  const CustomAppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: kPrimaryColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Profile',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            // InkWell(
            //   onTap: () {
            //     print('kkkk');
            //   },
            //   child: Icon(
            //     FontAwesomeIcons.ellipsisVertical,
            //     color: Colors.white,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
