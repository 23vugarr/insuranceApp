part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String finCode;
  final String password;

  const SignInEvent({required this.finCode, required this.password});

  @override
  List<Object> get props => super.props + [finCode, password];
}

class SignUpEvent extends AuthEvent {
  final String finCode;
  final String phoneNumber;
  final String password;

  const SignUpEvent({required this.finCode, required this.phoneNumber, required this.password});

  @override
  List<Object> get props => super.props + [finCode, phoneNumber, password];
}

// class RefreshTokenEvent extends AuthEvent {
//   final String refreshToken;

//   const RefreshTokenEvent({required this.refreshToken});

//   @override
//   List<Object> get props => super.props + [refreshToken];

// }

// class SignOutEvent extends AuthEvent {}

// class TokenExpirationEvent extends AuthEvent {}