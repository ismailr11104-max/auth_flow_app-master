import 'dart:io';

import 'package:auth_flow_app/core/error/exceptions.dart';
import 'package:auth_flow_app/core/network/supa_base/auth_client.dart';
import 'package:auth_flow_app/core/network/supa_base/storage/storage_client.dart';
import 'package:auth_flow_app/features/auth/data/datasources/profile_datasource.dart';
import 'package:auth_flow_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

class ProfileDataSourceImpl implements ProfileDataSource {
  final AuthClient _authClient;
  final StorageClient _storageClient;

  ProfileDataSourceImpl(this._authClient, this._storageClient);

  @override
  Future<UserModel> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final currentMetaData = _authClient.getCurrentUser?.userMetadata;
      final updateMateData = {
        ...currentMetaData ?? {},
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'avatar_url': photoUrl,
      };
      final response = await _authClient.updateProfile(
        UserAttributes(data: updateMateData),
      );
      return UserModel.fromSupaBaseUser(response.user!);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadProfilePicture({required String filePath}) async {
    try {
      final userId = _authClient.getCurrentUser?.id;
      final fileExt = filePath.split('.').last;
      await _storageClient.uploadFile(
        bucket: 'avatar',
        path: '$userId/avatar.$fileExt',
        file: File(filePath),
        options: const FileOptions(upsert: true),
      );
      final url = await _storageClient.getFileUrl(
        bucketName: 'avatar',
        path: '$userId/avatar.$fileExt',
      );
      await _authClient.updateProfile(
        UserAttributes(
          data: {
            ..._authClient.getCurrentUser?.userMetadata ?? {},
            'avatar_url': url,
          },
        ),
      );
      return url;
    } catch (e) {
      throw ServerException(
        'Failed to upload profile picture: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      return await _authClient.deleteAccount();
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to delete account: ${e.toString()}');
    }
  }
}
