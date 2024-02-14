import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/auth/register/register_cubit.dart';
import 'package:app/widgets/custom_bottom.dart';
import 'package:app/widgets/text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPageBottomSheet extends StatefulWidget {
  const RegisterPageBottomSheet({super.key, required this.isLoading});
  final bool isLoading;

  @override
  State<RegisterPageBottomSheet> createState() =>
      _RegisterPageBottomSheetState();
}

class _RegisterPageBottomSheetState extends State<RegisterPageBottomSheet> {
  GlobalKey<FormState> globalKey = GlobalKey();
  bool isPressed = false;
  bool isActive = false;
  TextEditingController userName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var register = context.read<RegisterCubit>();
    final isDark = context.read<LoginCubit>().isDark;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: 32,
          left: 32,
          top: 12,
        ),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signup',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Color(0xff2b2c33),
                    fontSize: 25),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  controller: userName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "user name is required";
                    } else {
                      return null;
                    }
                  },
                  hintText: 'User Name'),
              const SizedBox(height: 8),
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
                      return null;
                    }
                  },
                  obscureText: true,
                  hintText: 'Password'),
              const SizedBox(height: 8),
              CustomTextField(
                  controller: confirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'confirm password is required';
                    }
                    if (password.text != confirmPassword.text) {
                      return 'Password Do not match';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  hintText: 'Confirm Password'),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPressed = !isPressed;
                        isActive = isPressed;
                      });
                    },
                    child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: isPressed ? kPrimaryColor : Colors.grey,
                        ),
                        child: isPressed
                            ? Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              )
                            : null),
                  ),
                  const SizedBox(width: 8),
                  Text('I read & agree with',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  TextButton(onPressed: () {}, child: Text('terms & policy'))
                ],
              ),
              const SizedBox(height: 16),
              CustomBottom(
                onPressed: () async {
                  if (isActive && globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    await register.register(
                        emailAddress: emailAddress.text,
                        password: password.text,
                        userName: userName.text,
                        context: context);
                    if (register.state is RegisterSuccess) {
                      userName.clear();
                      emailAddress.clear();
                      password.clear();
                      confirmPassword.clear();
                    }
                  }
                },
                enableFeedback: isActive,
                isLoading: widget.isLoading,
                colorText: Colors.white,
                colorBottom: kPrimaryColor,
                text: 'Signup Now',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
