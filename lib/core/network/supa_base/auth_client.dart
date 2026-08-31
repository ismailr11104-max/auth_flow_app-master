import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthClient {
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  });
}
