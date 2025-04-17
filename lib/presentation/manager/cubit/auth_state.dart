part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String msg;

  AuthFailure({required this.msg});
}

final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginStudentSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String msg;

  LoginFailure({required this.msg});
}

final class LogoutInitial extends AuthState {}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}
