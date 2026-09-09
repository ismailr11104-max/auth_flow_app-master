import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageClient {
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
    required FileOptions options,
  });

  Future<String> getFileUrl({required String bucketName, required String path});
}
