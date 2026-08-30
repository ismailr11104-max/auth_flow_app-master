import 'package:auth_flow_app/core/error/failures.dart';
import 'package:auth_flow_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> updateProfile({
    String? displayName,
    String? photoUrl,
  });

  Future<Either<Failure, String>> uploadProfilePicture({
    required String filePath,
  });

  Future<Either<Failure, void>> deleteAccount();
}