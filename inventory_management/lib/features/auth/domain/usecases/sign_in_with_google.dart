import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle({required this.repository});

  Future<User?> call() {
    return repository.signInWithGoogle();
  }
}
