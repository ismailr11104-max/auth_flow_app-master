import 'dart:typed_data';

import 'package:auth_flow_app/core/network/supa_base/storage/storage_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageClientImpl extends StorageClient {
  final SupabaseClient _client;

  StorageClientImpl(this._client);

  @override
  String getPublicUrl({required String bucket, required String path}) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  @override
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required Uint8List fileBytes,
    String? contentType,
  }) async {
    await _client.storage
        .from(bucket)
        .uploadBinary(
          path,
          fileBytes,
          fileOptions: FileOptions(contentType: contentType, upsert: true),
        );
    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
