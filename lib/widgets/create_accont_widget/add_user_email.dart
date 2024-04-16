import 'package:app/widgets/create_accont_widget/add_user_text_filed.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AddUserEmail extends StatefulWidget {
  const AddUserEmail({super.key, required this.size, required this.email});

  final Size size;
  final TextEditingController email;

  @override
  State<AddUserEmail> createState() => _AddUserEmailState();
}

class _AddUserEmailState extends State<AddUserEmail> {
  Color iconColor = Color(0xffc3c5c5);

  @override
  void initState() {
    super.initState();
    widget.email.addListener(updateIconColor);
  }

  @override
  void dispose() {
    widget.email.removeListener(updateIconColor);
    super.dispose();
  }

  void updateIconColor() {
    setState(() {
      iconColor = widget.email.text.isEmpty ? Color(0xffc3c5c5) : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddUserTextField(
      size: widget.size,
      hintText: 'Email',
      textInputType: TextInputType.emailAddress,
      iconColor: iconColor,
      controller: widget.email,
      suffixIcon: Icon(Icons.email_outlined,
          size: widget.size.width * .05, color: iconColor),
      validator: (value) {
        if (value!.isEmpty) {
          return 'email address is required';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        } else {
          return null;
        }
      },
    );
  }
}
