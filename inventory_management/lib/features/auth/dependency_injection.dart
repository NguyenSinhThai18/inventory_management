import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/auth_supabase_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/sign_in_with_google.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource();
});

final authSupabaseDatasourceProvider = Provider<AuthSupabaseDatasource>((ref) {
  return AuthSupabaseDatasource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDatasource: ref.watch(authRemoteDatasourceProvider),

    supabaseDatasource: ref.watch(authSupabaseDatasourceProvider),
  );
});

final signInWithGoogleProvider = Provider<SignInWithGoogle>((ref) {
  return SignInWithGoogle(repository: ref.watch(authRepositoryProvider));
});
