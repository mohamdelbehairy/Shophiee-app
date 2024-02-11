import 'package:app/cubit/auth/login/login_page_cubit.dart';
import 'package:app/cubit/theme/theme_cubit.dart';
import 'package:app/widgets/profile_page/card_two_profile/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProfileCardTwo extends StatelessWidget {
  const CustomProfileCardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<LoginCubit>().isDark;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: isDark
                    ? Colors.grey.withOpacity(.1)
                    : Colors.grey.withOpacity(.4),
              ),
            ]),
        child: Card(
          color: isDark
              ? Color(0xff2b2c33)
              : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Friends',
                      style:
                      TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: size.height *.02
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              CustomProfileListView(),
              SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}
