import 'package:app/widgets/settings/app_bar.dart';
import 'package:app/widgets/settings/card_one.dart';
import 'package:app/widgets/settings/card_two.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarSettings(),
            CustomCardOne(),
            CustomCardTwo(),
          ],
        ),
      ),
    );
  }
}
