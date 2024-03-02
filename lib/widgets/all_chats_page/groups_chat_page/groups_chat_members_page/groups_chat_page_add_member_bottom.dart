import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupsChatPageAddMemberBottom extends StatelessWidget {
  const GroupsChatPageAddMemberBottom({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .03),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.plus,
              color: Colors.blue, size: size.height * .025),
          SizedBox(width: size.width * .025),
          Text('Add a member',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: size.height * .018,
                  fontWeight: FontWeight.normal))
        ],
      ),
    );
  }
}
