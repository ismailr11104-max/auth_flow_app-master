import 'package:auth_flow_app/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();

  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {
  const PhoneAuthInitial();
}

class PhoneAuthLoading extends PhoneAuthState {
  const PhoneAuthLoading();
}

class OTPSent extends PhoneAuthState {
  final String phoneNumber;

  const OTPSent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneAuthSuccess extends PhoneAuthState {
  final UserEntity user;

  const PhoneAuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class PhoneAuthError extends PhoneAuthState {
  final String message;

  const PhoneAuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
