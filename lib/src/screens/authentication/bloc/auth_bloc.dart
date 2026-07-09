import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/base/bloc/bloc_base/bloc_base.dart';
import 'package:maratha_shivmudra/core/base/bloc/event/base_event.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BlocBase<AuthEvent, AuthState> with GetItHelperMixin {
  AuthBloc() : super(AuthInitialState());

  late final GlobalKey<FormState> formKey;
  late final TextEditingController phoneController;
  ConfirmationResult? _confirmationResult;

  @override
  void init() {
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    super.init();
  }

  @override
  void mapEventToState() {
    on<OtpInitiatedEvent>((event, emit) => emit(AuthVerificationState()));

    on<OtpVerifiedEvent>(
      (event, emit) => emit(AuthSuccessState(isFormFilled: event.isFormFilled)),
    );

    on<ApiStatusEvent>((event, emit) {
      if (state is AuthInitialState) {
        emit(
          (state as AuthInitialState).copyWith(
            isLoading: event.isLoading,
            hasError: event.hasError,
            errorMessage: event.errorMessage,
          ),
        );
      } else if (state is AuthVerificationState) {
        emit(
          (state as AuthVerificationState).copyWith(
            isLoading: event.isLoading,
            hasError: event.hasError,
            errorMessage: event.errorMessage,
          ),
        );
      }
    });
  }

  Future<void> setUserData() async {
    final db = FirebaseFirestore.instance;
    final phoneNumber = getData<String>('mobileNumber');

    final referralId = Uri.base.queryParameters['ref'];
    final docRef = db.collection(phoneNumber!).doc('personal_info');

    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      await docRef.set(
        {
          'mobile_no': phoneNumber,
          'referral_id': referralId ?? 'NONE',
        },
        SetOptions(merge: true),
      );
      add(OtpVerifiedEvent(isFormFilled: false));
    } else {
      final docRef = db.collection(phoneNumber).doc('form_info');

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final ss = getIt<SecureStorage>();
        ss.setLoginFlag(true);
        add(OtpVerifiedEvent(isFormFilled: true));
      } else {
        add(OtpVerifiedEvent(isFormFilled: false));
      }
    }
  }

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Please enter a valid phone number.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'captcha-check-failed':
        return 'Verification challenge failed. Please try again.';
      case 'missing-app-credential':
        return 'Verification challenge failed. Please reload and try again.';
      case 'app-not-authorized':
        return 'This domain is not authorized for phone authentication.';
      case 'operation-not-allowed':
        return 'Phone authentication is not enabled for this project.';
      case 'invalid-verification-code':
        return 'Invalid OTP. Please enter the correct code.';
      case 'session-expired':
        return 'OTP has expired. Please request a new code.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }

  Future<bool> initiateOtp() async {
    final phoneNumber = phoneController.text.replaceAll(' ', '');
    final normalizedNumber = '+91$phoneNumber';

    setData<String>('mobileNumber', phoneNumber);

    try {
      _confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(normalizedNumber);

      add(OtpInitiatedEvent());
      add(ApiStatusEvent(isLoading: false, hasError: false, errorMessage: null));
      return true;
    } on FirebaseAuthException catch (e) {
      add(
        ApiStatusEvent(
          isLoading: false,
          hasError: true,
          errorMessage: _mapAuthError(e),
        ),
      );
      return false;
    } catch (_) {
      add(
        ApiStatusEvent(
          isLoading: false,
          hasError: true,
          errorMessage: 'Unable to send OTP right now. Please try again.',
        ),
      );
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    final phoneNumber = getData<String>('mobileNumber');
    if (phoneNumber == null || _confirmationResult == null) {
      add(
        ApiStatusEvent(
          isLoading: false,
          hasError: true,
          errorMessage: 'Please request OTP again before verifying.',
        ),
      );
      return false;
    }

    try {
      final userCredential = await _confirmationResult!.confirm(otp);
      final isSuccess = userCredential.user != null;

      if (!isSuccess) {
        add(
          ApiStatusEvent(
            isLoading: false,
            hasError: true,
            errorMessage: 'OTP verification failed. Please try again.',
          ),
        );
        return false;
      }

      await setUserData();
      add(ApiStatusEvent(isLoading: false, hasError: false, errorMessage: null));
      return true;
    } on FirebaseAuthException catch (e) {
      add(
        ApiStatusEvent(
          isLoading: false,
          hasError: true,
          errorMessage: _mapAuthError(e),
        ),
      );
      return false;
    } catch (_) {
      add(
        ApiStatusEvent(
          isLoading: false,
          hasError: true,
          errorMessage: 'Unable to verify OTP right now. Please try again.',
        ),
      );
      return false;
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
