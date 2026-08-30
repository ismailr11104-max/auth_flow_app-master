import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String? displayName;
  final String? photoUrl;

  const UpdateProfileEvent({this.displayName, this.photoUrl});

  @override
  List<Object?> get props => [displayName, photoUrl];
}

class UploadProfilePictureEvent extends ProfileEvent {
  final String filePath;

  const UploadProfilePictureEvent({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();
}
