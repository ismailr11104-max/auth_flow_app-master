import 'package:auth_flow_app/core/network/supa_base/auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthClientStub implements AuthClient {
  final GoTrueClient client;

  AuthClientStub(this.client);

  @override
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await client.signUp(
      email: email,
      password: password,
      data: {'name': 'Ali'},
    );
  }
}
