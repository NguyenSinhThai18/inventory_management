import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependency_injection.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(const AuthState());

  Future<bool> login() async {
    try {
      state = state.copyWith(isLoading: true);

      final user = await ref.read(signInWithGoogleProvider).call();

      if (user == null) {
        return false;
      }

      await ref.read(authRepositoryProvider).saveUser(user);

      return true;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class AuthState {
  final bool isLoading;

  const AuthState({this.isLoading = false});

  AuthState copyWith({bool? isLoading}) {
    return AuthState(isLoading: isLoading ?? this.isLoading);
  }
}
