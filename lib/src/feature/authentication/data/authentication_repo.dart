import 'dart:developer';

import 'package:ecom/src/utils/appleSignature.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationRepo {
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = Crypt().generateNonce();
      final nonce = Crypt().sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      /// Given name need to store it locally otherwise it will null return from next time returns only one
      final fixDisplayNameFromApple = [
        appleCredential.givenName ?? '',
        appleCredential.familyName ?? '',
      ].join(' ').trim();
      log("My name$fixDisplayNameFromApple");
      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      UserCredential us =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      if (us.user!.displayName == null || us.user!.displayName == "") {
        await Future.wait([
          FirebaseAuth.instance.currentUser!
              .updateDisplayName(fixDisplayNameFromApple),
          FirebaseAuth.instance.currentUser!.reload(),
        ]);
      } else {
        log("Already Present");
      }

      return us;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
          "google.com") {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
      } else {
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      log("email:$email password:$password");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }
}
