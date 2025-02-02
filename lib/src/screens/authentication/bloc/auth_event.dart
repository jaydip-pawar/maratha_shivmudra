part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends BaseEvent {}

class OtpInitiatedEvent extends AuthEvent {}

class OtpVerifiedEvent extends AuthEvent {}
