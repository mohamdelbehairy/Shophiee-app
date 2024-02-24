import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/widgets/custom_bottom.dart';
import 'package:app/widgets/text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBottomSheet extends StatefulWidget {
  const LoginPageBottomSheet({super.key});
  @override
  State<LoginPageBottomSheet> createState() => _LoginPageBottomSheetState();
}

class _LoginPageBottomSheetState extends State<LoginPageBottomSheet> {
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var login = (context).read<LoginCubit>();
    final isDark = context.read<LoginCubit>().isDark;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: 32,
          left: 32,
        ),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 16),
              CustomTextField(
                  controller: emailAddress,
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
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email Address'),
              const SizedBox(height: 8),
              CustomTextField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    } else {
                      print(password.text);
                      return null;
                    }
                  },
                  obscureText: true,
                  hintText: 'Enter Password'),
              const SizedBox(height: 22),
              CustomBottom(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        globalKey.currentState!.save();
                        await login.login(
                            context: context,
                            emailAddress: emailAddress.text,
                            password: password.text);
                        if (login.state is LoginSuccess) {
                          emailAddress.clear();
                          password.clear();
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  isLoading: isLoading,
                  colorText: Colors.white,
                  colorBottom: kPrimaryColor,
                  text: 'Get Login'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      login.forgetPassword(
                          emailAddress: emailAddress.text, context: context);
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
