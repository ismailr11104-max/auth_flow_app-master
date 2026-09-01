import 'package:auth_flow_app/core/error/exceptions.dart';
import 'package:auth_flow_app/core/network/supa_base/auth_client.dart';
import 'package:auth_flow_app/features/auth/data/datasources/email_auth_datasource.dart';
import 'package:auth_flow_app/features/auth/data/models/user_model.dart';

class EmailAuthDataSourceImpl implements EmailAuthDataSource {
  final AuthClient _authClient;

  EmailAuthDataSourceImpl(this._authClient);

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _authClient.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
      if (response.user == null) {
        throw AuthException('Failed to sign up');
      }
      return UserModel.fromSupaBaseUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authClient.signIn(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw ServerException('No account found with this email address.');
      }
      return UserModel.fromSupaBaseUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException('Failed to sign in: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      _authClient.resetPassword(email: email);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to reset password: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _authClient.verifyPasswordResetOtp(
        email: email,
        otp: otp,
      );
      if (response.user == null) {
        throw ServerException('verify OTP Failed - Invalid OTP or Expire');
      }
      return UserModel.fromSupaBaseUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to verify email: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePassword({required String password}) async {
    try {
      await _authClient.updatePassword(password: password);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update password: ${e.toString()}');
    }
  }

  @override
  Future<void> sendMagicLink({required String email}) async {
    try {
      // TODO: Implement sendMagicLink
      throw UnimplementedError('sendMagicLink not implemented yet');
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to send magic link: ${e.toString()}');
    }
  }
}
