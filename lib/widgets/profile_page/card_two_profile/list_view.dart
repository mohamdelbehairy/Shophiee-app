import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class CustomProfileListView extends StatelessWidget {
  const CustomProfileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: ((context, index) {
            if (index == 4) {
              return Padding(
                padding: EdgeInsets.only(left: 12),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    '+70',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://statusneo.com/wp-content/uploads/2023/02/MicrosoftTeams-image551ad57e01403f080a9df51975ac40b6efba82553c323a742b42b1c71c1e45f1.jpg'),
                ),
              );
            }
          })),
    );
  }
}
