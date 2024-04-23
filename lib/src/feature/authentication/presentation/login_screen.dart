import 'dart:developer';
import 'dart:ui';
import 'package:ecom/src/common_widget/loader.dart';
import 'package:ecom/src/common_widget/password_reset.dart';
import 'package:ecom/src/common_widget/stadium_button.dart';
import 'package:ecom/src/constant/app_assets.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/feature/authentication/controller/authentication_controller.dart';
import 'package:ecom/src/feature/authentication/presentation/signup_screen.dart';
import 'package:ecom/src/routes/Routes.dart';
import 'package:ecom/src/utils/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              AppColors.backgroundColor2,
              AppColors.backgroundColor2,
              AppColors.backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.03),
              const Text(
                "Hello Again!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 37,
                  color: AppColors.textColor1,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Wellcome back vou've\nbeen missed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27, color: AppColors.textColor2, height: 1.2),
              ),
              SizedBox(height: size.height * 0.04),
              // for username and password

              myTextField(
                  hint: "Enter Email",
                  color: Colors.white,
                  type: TextFieldType.email,
                  obscureText: false,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),
              myTextField(
                  hint: "Password",
                  color: Colors.black26,
                  type: TextFieldType.password,
                  obscureText: obsecure,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onPressed: () {
                    setState(() {
                      obsecure = !obsecure;
                    });
                  }),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    context.push('/${Routes.passwordReset}');
                  },
                  child: const Text(
                    "Recovery Password               ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textColor2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    StadiumButton(
                      title: "Sign In",
                      onTap: () {
                        final navigator = Navigator.of(context);
                        buildShowDialog(context);
                        if (_formKey.currentState!.validate()) {
                          ref.read(authProvider).signInWithEmailAndPassword(
                              (value) {
                            if (value.item1) {
                              context.pop();
                              // navigator.pop();
                              log("success");
                            } else {
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.item2),
                                ),
                              );
                            }
                          },
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.06),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       height: 2,
                    //       width: size.width * 0.2,
                    //       color: Colors.black12,
                    //     ),
                    //     const Text(
                    //       "  Or continue with   ",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: AppColors.textColor2,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 2,
                    //       width: size.width * 0.2,
                    //       color: Colors.black12,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: size.height * 0.06),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //         onTap: () {
                    //           ref.read(authProvider).signInWithGoogle((value) {
                    //             if (value.item1) {
                    //               log("success");
                    //               context.pop();
                    //               context.pop();
                    //             } else {
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                 SnackBar(
                    //                   content: Text(value.item2),
                    //                 ),
                    //               );
                    //             }
                    //           });
                    //         },
                    //         child: socialIcon(AppAssets.googleImage)),
                    //     socialIcon(AppAssets.appleImage),
                    //   ],
                    // ),
                    SizedBox(height: size.height * 0.07),
                    InkWell(
                      onTap: () {
                        context.go('/${Routes.signUp}');
                      },
                      child: const Text.rich(
                        TextSpan(
                            text: "Not a member? ",
                            style: TextStyle(
                              color: AppColors.textColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Register now",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Image.asset(
        image,
        height: 35,
      ),
    );
  }

  Container myTextField(
      {required obscureText,
      required TextFieldType type,
      required TextEditingController controller,
      required hint,
      required Color color,
      required TextInputType keyboardType,
      VoidCallback? onPressed}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        inputFormatters: const [],
        validator: (value) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          if (value!.isEmpty) {
            return "Please enter $hint";
          }

          switch (type) {
            case TextFieldType.email:
              if (!RegExp(pattern).hasMatch(value)) {
                return AppStrings.invaildEmail;
              }
              break;
            case TextFieldType.password:
              if (obscureText && value.length < 6) {
                return "Password must be at least 6 characters";
              }
              break;
            case TextFieldType.name:
              if (value.length < 3) {
                return "Name must be at least 3 characters";
              }
              break;
            case TextFieldType.confirmPassword:
              if (value != _passwordController.text) {
                return "Password does not match";
              }
              break;
          }

          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
            ),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 19,
            ),
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.visibility_off_outlined,
                color: color,
              ),
            )),
      ),
    );
  }
}
