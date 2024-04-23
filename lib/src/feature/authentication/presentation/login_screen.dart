import 'dart:developer';

import 'package:ecom/src/common_widget/stadium_button.dart';
import 'package:ecom/src/constant/app_assets.dart';
import 'package:ecom/src/constant/app_colors.dart';
import 'package:ecom/src/feature/authentication/controller/authentication_controller.dart';
import 'package:ecom/src/utils/device_info.dart';
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
                hint: "Enter username",
                color: Colors.white,
                obscureText: false,
                controller: _emailController),
            myTextField(
                hint: "Password",
                color: Colors.black26,
                obscureText: true,
                controller: _passwordController),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Recovery Password               ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textColor2,
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
                      ref.read(authProvider).signInWithEmailAndPassword(
                          (value) {
                        if (value.item1) {
                          log("success");
                          // Navigator.pushNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value.item2),
                            ),
                          );
                        }
                      },
                          email: _emailController.text,
                          password: _passwordController.text);
                    },
                  ),
                  // for sign in button
                  // GestureDetector(
                  //   onTap: () {
                  //     ref.read(authProvider).signInWithEmailAndPassword(
                  //         (value) {
                  //       if (value.item1) {
                  //         log("success");
                  //         // Navigator.pushNamed(context, "/home");
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text(value.item2),
                  //           ),
                  //         );
                  //       }
                  //     },
                  //         email: _emailController.text,
                  //         password: _passwordController.text);
                  //   },
                  //   child: Container(
                  //     width: size.width,
                  //     padding: const EdgeInsets.symmetric(vertical: 20),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.buttonColor,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: const Center(
                  //       child: Text(
                  //         "Sign In",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //           fontSize: 22,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: size.width * 0.2,
                        color: Colors.black12,
                      ),
                      const Text(
                        "  Or continue with   ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor2,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: size.width * 0.2,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            ref.read(authProvider).signInWithGoogle((value) {
                              if (value.item1) {
                                log("success");
                                context.pop();
                                context.pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(value.item2),
                                  ),
                                );
                              }
                            });
                          },
                          child: socialIcon(AppAssets.googleImage)),
                      socialIcon(AppAssets.appleImage),
                    ],
                  ),
                  SizedBox(height: size.height * 0.07),
                  const Text.rich(
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
                ],
              ),
            ),
          ],
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

  Container myTextField({
    required obscureText,
    required TextEditingController controller,
    required hint,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
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
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: color,
            )),
      ),
    );
  }
}
