import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthClient {
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });

  Future<void> resetPassword({required String email});
  Future<AuthResponse> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });
  Future<UserResponse> updatePassword({required String password});
  Future<AuthResponse> signInWithIdToken(
    OAuthProvider provider,
    String idToken,
  );

  Future<bool> signInWithOAuth(OAuthProvider provider, String callback);
  User? get getCurrentUser;
  User? get currentUser;

  Future<void> signOut();

  Stream<AuthState> get authStateChanges;

  Future<UserResponse> updateUser({String? name, String? avatarUrl});
  Future<void> deleteAccount();
}
