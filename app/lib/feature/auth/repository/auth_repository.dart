import 'package:flutter_huevo/feature/auth/provider/auth_provider.dart';

class AuthRepository {
  const AuthRepository({required this.authProvider});

  final AuthProvider authProvider;

  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return authProvider.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String?> signInWithGoogle() {
    return authProvider.signInWithGoogle();
  }

  Future<String?> signInWithApple() {
    return authProvider.signInWithApple();
  }

  Future<String?> signInAnonymously() {
    return authProvider.signInAnonymously();
  }

  Future<void> resetPassword(String email) {
    return authProvider.resetPassword(email);
  }
}
