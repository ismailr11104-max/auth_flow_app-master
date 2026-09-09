import 'dart:io';

import 'package:auth_flow_app/core/network/supa_base/storage/storage_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageClientImpl extends StorageClient {
  final SupabaseStorageClient clint;

  StorageClientImpl(this.clint);

  @override
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
    required FileOptions options,
  }) async {
    return await clint.from(bucket).upload(path, file, fileOptions: options);
  }

  @override
  Future<String> getFileUrl({
    required String bucketName,
    required String path,
  }) async {
    return clint.from(bucketName).getPublicUrl(path);
  }
}
