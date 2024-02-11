import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationTextField extends StatelessWidget {
  const VerificationTextField({super.key, required this.onChanged,});
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        onChanged: onChanged,
        cursorColor: const Color(0xff2b2c33),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '0',
          filled: true,
          fillColor: const Color(0xff2b2c33).withOpacity(.1),
        ),
        style: Theme.of(context).textTheme.titleLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
