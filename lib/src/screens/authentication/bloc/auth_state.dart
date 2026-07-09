part of 'auth_bloc.dart';

abstract class AuthState extends BaseState {}

class AuthInitialState extends AuthState {
  AuthInitialState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  AuthInitialState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return AuthInitialState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, errorMessage];
}

class AuthVerificationState extends AuthState {
  AuthVerificationState({
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  AuthVerificationState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return AuthVerificationState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, errorMessage];
}

class AuthSuccessState extends AuthState {
  AuthSuccessState({required this.isFormFilled});

  final bool isFormFilled;

  AuthSuccessState copyWith({bool? isFormFilled}) {
    return AuthSuccessState(
      isFormFilled: isFormFilled ?? this.isFormFilled,
    );
  }

  @override
  List<Object> get props => [isFormFilled];
}
