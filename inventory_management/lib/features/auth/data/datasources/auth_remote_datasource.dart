import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDatasource {
  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();

        final userCredential = await FirebaseAuth.instance.signInWithPopup(
          provider,
        );

        return userCredential.user;
      }

      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize();

      final GoogleSignInAccount googleUser = await signIn.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return userCredential.user;
    }
    // WEB CLOSE POPUP
    on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user' ||
          e.code == 'cancelled-popup-request') {
        return null;
      }

      rethrow;
    }
    // MOBILE CANCEL
    on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }

      rethrow;
    }
  }
}
