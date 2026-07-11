part of 'auth_bloc.dart';

abstract class AuthState extends BaseState {}

class AuthInitialState extends AuthState {
  AuthInitialState({
    this.isLoading = false,
    this.hasError = false,
    this.invalidOtp = false,
  });

  final bool isLoading;
  final bool hasError;
  final bool invalidOtp;

  AuthInitialState copyWith({
    bool? isLoading,
    bool? hasError,
    bool? invalidOtp,
  }) {
    return AuthInitialState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      invalidOtp: invalidOtp ?? this.invalidOtp,
    );
  }

  @override
  List<Object> get props => [isLoading, hasError, invalidOtp];
}

class AuthVerificationState extends AuthState {
  AuthVerificationState({
    this.isLoading = false,
    this.hasError = false,
    this.invalidOtp = false,
  });

  final bool isLoading;
  final bool hasError;
  final bool invalidOtp;

  AuthVerificationState copyWith({
    bool? isLoading,
    bool? hasError,
    bool? invalidOtp,
  }) {
    return AuthVerificationState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      invalidOtp: invalidOtp ?? this.invalidOtp,
    );
  }

  @override
  List<Object> get props => [isLoading, hasError, invalidOtp];
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
