part of 'auth_bloc.dart';

abstract class AuthState extends BaseState {}

class AuthInitialState extends AuthState {
  AuthInitialState({
    this.isLoading = false,
    this.hasError = false,
  });

  final bool isLoading;
  final bool hasError;

  AuthInitialState copyWith({
    bool? isLoading,
    bool? hasError,
  }) {
    return AuthInitialState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object> get props => [isLoading, hasError];
}

class AuthVerificationState extends AuthState {
  AuthVerificationState({
    this.isLoading = false,
    this.hasError = false,
  });

  final bool isLoading;
  final bool hasError;

  AuthVerificationState copyWith({
    bool? isLoading,
    bool? hasError,
  }) {
    return AuthVerificationState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object> get props => [isLoading, hasError];
}

class AuthSuccessState extends AuthState {}
