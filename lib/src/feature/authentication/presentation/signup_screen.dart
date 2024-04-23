import 'dart:developer';

import 'package:ecom/src/common_widget/loader.dart';
import 'package:ecom/src/common_widget/stadium_button.dart';
import 'package:ecom/src/constant/app_assets.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/constant/app_strings.dart';
import 'package:ecom/src/feature/authentication/controller/authentication_controller.dart';
import 'package:ecom/src/routes/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum TextFieldType { email, password, name, confirmPassword }

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool obsecure = true;
  bool obsecure2 = true;
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

              const SizedBox(height: 15),
              const Text(
                "Welcome ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27, color: AppColors.textColor2, height: 1.2),
              ),
              SizedBox(height: size.height * 0.04),
              // for username and password
              myTextField(
                  hint: "Enter Name",
                  color: Colors.white,
                  type: TextFieldType.name,
                  obscureText: false,
                  controller: _nameController,
                  keyboardType: TextInputType.name),
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
                  obscureText: obsecure,
                  type: TextFieldType.password,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  onPressed: () {
                    setState(() {
                      obsecure = !obsecure;
                    });
                  }),
              myTextField(
                  hint: "Confirm Password",
                  color: Colors.black26,
                  obscureText: obsecure2,
                  type: TextFieldType.confirmPassword,
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  onPressed: () {
                    setState(() {
                      obsecure2 = !obsecure2;
                    });
                  }),
              const SizedBox(height: 10),

              SizedBox(height: size.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    StadiumButton(
                      title: "Sign Up",
                      onTap: () {
                        buildShowDialog(context);
                        if (_formKey.currentState!.validate()) {
                          ref.read(authProvider).signUpWithEmailAndPassword(
                              (value) {
                            if (value.item1) {
                              Navigator.of(context).pop();
                              context.go("/${Routes.authCheck}");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.item2),
                                ),
                              );
                            }
                          },
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text);
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
                    // SizedBox(height: size.height * 0.07),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go("/login"),
                      child: const Text.rich(
                        TextSpan(
                            text: "Already a member? ",
                            style: TextStyle(
                              color: AppColors.textColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Login now",
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
