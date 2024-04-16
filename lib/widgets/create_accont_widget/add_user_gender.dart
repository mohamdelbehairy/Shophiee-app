import 'package:app/widgets/create_accont_widget/add_user_gender_drop_down.dart';
import 'package:app/widgets/create_accont_widget/add_user_text_filed.dart';
import 'package:flutter/material.dart';

class AddUserGender extends StatefulWidget {
  const AddUserGender({super.key, required this.size, required this.gender});

  final Size size;
  final TextEditingController gender;

  @override
  State<AddUserGender> createState() => _AddUserGenderState();
}

class _AddUserGenderState extends State<AddUserGender> {
  Color iconColor = Color(0xffc3c5c5);

  @override
  void initState() {
    super.initState();
    widget.gender.addListener(updateIconColor);
  }

  @override
  void dispose() {
    widget.gender.removeListener(updateIconColor);
    super.dispose();
  }

  void updateIconColor() {
    setState(() {
      iconColor = widget.gender.text.isEmpty ? Color(0xffc3c5c5) : Colors.black;
    });
  }

  final items = ['Male', 'Female'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AddUserTextField(
          enabled: false,
          size: widget.size,
          hintText: 'Gender',
          controller: widget.gender,
          iconColor: iconColor,
          validator: (value) {
            if (value!.isEmpty) {
              return 'gender is required';
            } else {
              return null;
            }
          },
        ),
        AddUserGenderDropDown(
            size: widget.size,
            iconColor: iconColor,
            items: items,
            gender: widget.gender)
      ],
    );
  }
}
