import 'package:auth_flow_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileUpdated extends ProfileState {
  final UserEntity user;

  const ProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfilePictureUploaded extends ProfileState {
  final String photoUrl;

  const ProfilePictureUploaded({required this.photoUrl});

  @override
  List<Object?> get props => [photoUrl];
}

class AccountDeleted extends ProfileState {
  const AccountDeleted();
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}
