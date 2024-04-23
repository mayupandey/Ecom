import 'dart:developer';
import 'package:ecom/src/feature/authentication/data/authentication_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

class AuthenticationState {
  UserCredential? userCredential;

  AuthenticationState({this.userCredential});
}

class AuthenticationController extends StateNotifier<AuthenticationState> {
  AuthenticationController() : super(AuthenticationState());
  final AuthenticationRepo _authenticationRepo = AuthenticationRepo();

  Future<void> signInWithGoogle(
      ValueSetter<Tuple2<bool, String>> onResponse) async {
    try {
      final res = await _authenticationRepo.signInWithGoogle();
      onResponse(const Tuple2(true, "Sucessfully logged in"));

      state = AuthenticationState(userCredential: res);
      onResponse(const Tuple2(true, "Sucessfully logged in"));
      // userCredential = res;
    } catch (e) {
      log("message$e");
      onResponse(Tuple2(false, "Error:${e.toString()}"));
    }
  }

  Future<void> signInWithApple(
      ValueSetter<Tuple2<bool, String>> onResponse) async {
    try {
      final res = await _authenticationRepo.signInWithApple();
      state = AuthenticationState(userCredential: res);
      onResponse(const Tuple2(true, "Sucessfully logged in"));
    } catch (e) {
      log("message$e");
      onResponse(Tuple2(false, "Error:${e.toString()}"));
    }
  }

  Future<void> signInWithEmailAndPassword(
      ValueSetter<Tuple2<bool, String>> onResponse,
      {required String email,
      required String password}) async {
    try {
      final res = await _authenticationRepo.signInWithEmail(
          email: email, password: password);
      state = AuthenticationState(userCredential: res);
      onResponse(const Tuple2(true, "Sucessfully logged in"));
    } catch (e) {
      onResponse(Tuple2(false, "Error:${e.toString()}"));
    }
  }

  Future<void> signUpWithEmailAndPassword(
      ValueSetter<Tuple2<bool, String>> onResponse,
      {required String email,
      required String password}) async {
    try {
      final res = await _authenticationRepo.signUpWithEmail(
          email: email, password: password);
      state = AuthenticationState(userCredential: res);
      onResponse(const Tuple2(true, "Sucessfully logged in"));
    } catch (e) {
      onResponse(Tuple2(false, "Error:${e.toString()}"));
    }
  }

  Future<void> signOut(
    ValueSetter<Tuple2<bool, String>> onResponse,
  ) async {
    try {
      final res = await _authenticationRepo.signOut();
      onResponse(const Tuple2(true, "Sucessfully logged out"));
    } catch (e) {
      onResponse(Tuple2(false, "Error:${e.toString()}"));
    }
  }
}

final authProvider = Provider<AuthenticationController>((ref) {
  return AuthenticationController();
});
