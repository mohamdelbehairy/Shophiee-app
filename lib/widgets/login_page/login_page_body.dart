import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/widgets/login_page/login_page_botom_sheet.dart';
import 'package:app/widgets/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage('assets/images/signPage.jpg'),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 50,
          right: 16,
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        Positioned(
            top: 50,
            left: 12,
            child: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                      (route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  size: 30,
                  color: Colors.white,
                ))),
        DraggableScrollableSheet(
          initialChildSize: 0.88,
          minChildSize: 0.75,
          maxChildSize: 0.88,
          builder: (context, controller) => SingleChildScrollView(
            reverse: true,
            child: Container(
              decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailure &&
                      state.errorMessage == 'invalid-credential') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: SnackBarWidget(
                          title: 'Opps, An Error Occoured',
                          icon: Icons.error_outline,
                          color: Colors.red,
                          message:
                              'There was a problem logging in. Check your email and password or create an account.'),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ));
                  } else if (state is LoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 5,
                        ),
                      ),
                      LoginPageBottomSheet(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
