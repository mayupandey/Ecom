import 'dart:developer';

import 'package:ecom/src/feature/authentication/presentation/login_screen.dart';
import 'package:ecom/src/feature/authentication/presentation/signup_screen.dart';
import 'package:ecom/src/feature/home/presentation/home_screen.dart';
import 'package:ecom/src/feature/navigation/presentation/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final currentUserProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

class AuthenticationCheck extends StatefulWidget {
  const AuthenticationCheck({super.key});

  @override
  State<AuthenticationCheck> createState() => _AuthenticationCheckState();
}

class _AuthenticationCheckState extends State<AuthenticationCheck> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final currentUserAsyncValue = watch.watch(currentUserProvider);

        return currentUserAsyncValue.when(
          data: (currentUser) {
            if (currentUser == null) {
              return const LoginScreen();
            } else {
              //TODO: Navigator Screen
              return const NavigationScreen();
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        );
      },
    );
  }
}
