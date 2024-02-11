import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/auth/register/register_cubit.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/widgets/register_page/register_page_bottom_sheet_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageBody extends StatelessWidget {
  const RegisterPageBody({super.key});

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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: Text(
                'Get Login',
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
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_sharp,
                  size: 30,
                  color: Colors.white,
                ))),
        DraggableScrollableSheet(
          initialChildSize: 0.90,
          minChildSize: 0.70,
          maxChildSize: 0.90,
          builder: (context, scrollable) => SingleChildScrollView(
            reverse: true,
            child: Container(
              decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 5,
                        ),
                      ),
                      RegisterPageBottomSheet(),
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
