part of 'auth_bloc.dart';

abstract class AuthState extends BaseState {}

class AuthInitialState extends AuthState {}

class AuthVerificationState extends AuthState {}

class AuthSuccessState extends AuthState {}
