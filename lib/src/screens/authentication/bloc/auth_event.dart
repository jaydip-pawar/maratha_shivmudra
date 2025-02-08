part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends BaseEvent {}

class OtpInitiatedEvent extends AuthEvent {}

class OtpVerifiedEvent extends AuthEvent {}

class ApiStatusEvent extends AuthEvent {
  ApiStatusEvent({
    required this.isLoading,
    required this.hasError,
  });

  final bool isLoading;
  final bool hasError;
}
