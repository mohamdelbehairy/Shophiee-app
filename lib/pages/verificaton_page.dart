import 'dart:async';

import 'package:app/cubit/auth/auth_settings/auth_settings_cubit.dart';
import 'package:app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key, required this.isDark});
  final bool isDark;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;
  Timer? nextScreenTimer;

  @override
  void initState() {
    super.initState();
    if (!isEmailVerified) {
      context.read<AuthSettingsCubit>().verificationEmail();
    }

    timer =
        Timer.periodic(Duration(seconds: 3), (timer) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();
    nextScreenTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.withOpacity(.010),
          elevation: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verification Security Code',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: widget.isDark ? Colors.white : Colors.black)),
            SizedBox(height: 8),
            Text(
                'Just enable the dark mode and be\n king to the nightmare world',
                style: TextStyle(
                    fontSize: 18,
                    color: widget.isDark ? Colors.white : Colors.black)),
            SizedBox(height: 24),
            if (isEmailVerified) Center(child: CircularProgressIndicator()),
            SizedBox(height: 8),
            Center(
                child: Text('Verifing Code',
                    style: TextStyle(
                        color: widget.isDark ? Colors.white : Colors.black))),
            SizedBox(height: 32),
            TextButton(
                onPressed: () {
                  context.read<AuthSettingsCubit>().verificationEmail();
                },
                child:
                    Center(child: Text("Didn't Get Verification link? Resend")))
          ],
        ),
      ),
    );
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      nextScreenTimer = Timer.periodic(
          const Duration(seconds: 3),
          (timer) => getnav.Get.to(() => LoginPage(),
              transition: getnav.Transition.leftToRight));
      timer?.cancel();
    }
  }
}
