import 'package:app/widgets/create_accont_widget/phone_number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class AddUserPhoneNumber extends StatefulWidget {
  const AddUserPhoneNumber(
      {super.key, required this.size, required this.phoneNumber, required this.onChanged});

  final Size size;
  final TextEditingController phoneNumber;
  final Function(PhoneNumber) onChanged;

  @override
  State<AddUserPhoneNumber> createState() => _AddUserPhoneNumberState();
}

class _AddUserPhoneNumberState extends State<AddUserPhoneNumber> {
  Color iconColor = Color(0xffc3c5c5);
  bool disableLengthCheck = true;

  @override
  void initState() {
    super.initState();
    widget.phoneNumber.addListener(updatePhoneNumberDetails);
  }

  @override
  void dispose() {
    widget.phoneNumber.removeListener(updatePhoneNumberDetails);
    super.dispose();
  }

  void updatePhoneNumberDetails() {
    setState(() {
      iconColor =
          widget.phoneNumber.text.isEmpty ? Color(0xffc3c5c5) : Colors.black;
      disableLengthCheck = widget.phoneNumber.text.isEmpty ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhoneNumberTextField(
        phoneNumber: widget.phoneNumber,
        size: widget.size,
        hintText: 'Phone Number',
        dropDownColor: iconColor,
        disableLengthCheck: disableLengthCheck,
        onChanged: widget.onChanged);
  }
}
