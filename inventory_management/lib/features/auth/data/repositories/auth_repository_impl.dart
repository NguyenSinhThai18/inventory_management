import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_supabase_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  final AuthSupabaseDatasource supabaseDatasource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.supabaseDatasource,
  });

  @override
  Future<User?> signInWithGoogle() {
    return remoteDatasource.signInWithGoogle();
  }

  @override
  Future<void> saveUser(User user) {
    return supabaseDatasource.saveUser(user);
  }
}
