import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddUserGenderDropDown extends StatelessWidget {
  const AddUserGenderDropDown(
      {super.key,
      required this.size,
      required this.iconColor,
      required this.items,
      required this.gender});

  final Size size;
  final Color iconColor;
  final List<String> items;
  final TextEditingController gender;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: size.width * .015,
        child: DropdownButton(
            icon: Icon(FontAwesomeIcons.caretDown,
                color: iconColor, size: size.width * .045),
            items: items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                gender.text = value;
              }
            },
            underline: Container(),
            borderRadius: BorderRadius.circular(size.width * .03)));
  }
}
