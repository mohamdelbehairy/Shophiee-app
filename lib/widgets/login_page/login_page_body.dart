import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/widgets/login_page/login_page_bottom_sheet.dart';
import 'package:app/utils/widget/auth/auth_positioned_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
            image: AssetImage('assets/images/signPage.jpg'), fit: BoxFit.cover),
        AuthPositionedIcon(
            top: 50,
            right: 16,
            onPressed: () => getnav.Get.to(() => RegisterPage(),
                transition: getnav.Transition.rightToLeft),
            child: const Text('Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        AuthPositionedIcon(
            top: 50,
            left: 0,
            onPressed: () => getnav.Get.to(() => RegisterPage(),
                transition: getnav.Transition.rightToLeft),
            child: const Icon(Icons.arrow_back_sharp,
                size: 30, color: Colors.white)),
        LoginPageBottomSheet(isDark: isDark),
      ],
    );
  }
}
