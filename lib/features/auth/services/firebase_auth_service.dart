import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matchster/core/constants/app_constants.dart';

class FirebaseAuthService {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;

  static Future<void> initGoogleSign() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId: AppConstants.serverClientId,
      );
    }
    isInitialize = true;
  }

  static Future<UserCredential> signWithGoogle() async {
    try {
      initGoogleSign();
      final GoogleSignInAccount googleAccount =
          await _googleSignIn.authenticate();
      final idToken = googleAccount.authentication.idToken;
      final authorizationClient = googleAccount.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(["email", 'profile']);

      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authentiction2 = await authorizationClient.authorizationForScopes(
          ["email", 'profile'],
        );

        if (authentiction2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authentiction2;
      }
      final credentials = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credentials);

      debugPrint(
        "UserCredential ${userCredential.user!.displayName}".toString(),
      );

      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> singOut() async {
    try {
      _googleSignIn.signOut();
      firebaseAuth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
