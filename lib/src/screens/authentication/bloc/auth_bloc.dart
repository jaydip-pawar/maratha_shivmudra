import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
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
  String? _sessionId;

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
            invalidOtp: event.invalidOtp,
          ),
        );
      } else if (state is AuthVerificationState) {
        emit(
          (state as AuthVerificationState).copyWith(
            isLoading: event.isLoading,
            hasError: event.hasError,
            invalidOtp: event.invalidOtp,
          ),
        );
      }
    });

    on<BackEvent>((event, emit) {
      if (state is AuthVerificationState) {
        emit(
          AuthInitialState(
            isLoading: false,
            hasError: false,
            invalidOtp: false,
          ),
        );
        phoneController.clear();
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
      await docRef.set({
        'mobile_no': phoneNumber,
        'referral_id': referralId ?? 'NONE',
      }, SetOptions(merge: true));
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

  Future<bool> initiateOtp() async {
    try {
      String phoneNumber = phoneController.text.replaceAll(' ', '');

      setData<String>('mobileNumber', phoneNumber);
      phoneNumber = '+91$phoneNumber';

      final response = await getIt<AuthRepository>().sendOTP(phoneNumber);

      if (response.isLeft() || !response.getRight().isSuccess) {
        add(ApiStatusEvent(isLoading: false, hasError: true));
        return false;
      }
      _sessionId = response.getRight().details;

      add(OtpInitiatedEvent());

      add(ApiStatusEvent(isLoading: false, hasError: false));

      return true;
    } catch (e, s) {
      add(ApiStatusEvent(isLoading: false, hasError: true));

      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      if (_sessionId == null) return false;

      final response = await getIt<AuthRepository>().verifyOTP(
        sessionId: _sessionId!,
        otp: otp,
      );

      if (response.isLeft() || !response.getRight().isSuccess) {
        final invalidOtp = response.getLeft().error.code == 1001;
        add(
          ApiStatusEvent(
            isLoading: false,
            hasError: true,
            invalidOtp: invalidOtp,
          ),
        );

        return false;
      }

      await setUserData();

      add(ApiStatusEvent(isLoading: false, hasError: false));

      return true;
    } catch (_) {
      add(ApiStatusEvent(isLoading: false, hasError: true));

      return false;
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
