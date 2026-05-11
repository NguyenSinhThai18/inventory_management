import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDatasource {
  Future<User?> signInWithGoogle() async {
    UserCredential userCredential;

    if (kIsWeb) {
      final provider = GoogleAuthProvider();

      userCredential = await FirebaseAuth.instance.signInWithPopup(provider);
    } else {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize();

      final GoogleSignInAccount googleUser = await signIn.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
    }

    return userCredential.user;
  }
}
