import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:maratha_shivmudra/core/base/bloc/bloc_base/bloc_base.dart';
import 'package:maratha_shivmudra/core/base/bloc/event/base_event.dart';
import 'package:maratha_shivmudra/core/base/bloc/state/base_state.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/mixins/get_it_helper_mixin.dart';
import 'package:otpless_flutter_web/otpless_flutter_web.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BlocBase<AuthEvent, AuthState> with GetItHelperMixin {
  AuthBloc() : super(AuthInitialState());

  late final GlobalKey<FormState> formKey;
  late final TextEditingController phoneController;
  late final Otpless _otpLess;

  @override
  void init() {
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    _otpLess = Otpless();
    _otpLess.headlessResponse(_onHeadlessResult);
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
          ),
        );
      } else if (state is AuthVerificationState) {
        emit(
          (state as AuthVerificationState).copyWith(
            isLoading: event.isLoading,
            hasError: event.hasError,
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

  Future<bool> _onHeadlessResult(dynamic result) async {
    debugPrint(result.toString());
    final json = jsonDecode(result.toString());

    if (json['statusCode'] == 200) {
      switch (json['responseType']) {
        case 'INITIATE':
          final model = OLInitiateModel.fromJson(json as Map<String, dynamic>);
          if (model.success) {
            add(OtpInitiatedEvent());
            return true;
          }
          return false;
        case 'VERIFY':
          final model = OLInitiateModel.fromJson(json as Map<String, dynamic>);
          if (model.success) {
            return true;
          }
          return false;
        case 'ONETAP':
          final model = OLVerifiedModel.fromJson(json as Map<String, dynamic>);
          if (model.success) {
            await setUserData();
            return true;
          }
          return false;
        case 'OTP_AUTO_READ':
          return true;
        default:
          return false;
      }
    }

    return false;
  }

  Future<bool> initiateOtp() async {
    final phoneNumber = phoneController.text.replaceAll(' ', '');

    setData<String>('mobileNumber', phoneNumber);
    final completer = Completer<bool>();

    Map<String, dynamic> arg = {
      "phone": phoneNumber,
      "countryCode": "91",
    };

    _otpLess.initiatePhoneAuth(
      (result) async {
        final isSuccess = await _onHeadlessResult(result);
        if (isSuccess) {
          add(ApiStatusEvent(isLoading: false, hasError: false));
        } else {
          add(ApiStatusEvent(isLoading: false, hasError: true));
        }
        completer.complete(isSuccess);
      },
      arg,
    );

    return completer.future;
  }

  Future<bool> verifyOtp(String otp) async {
    final phoneNumber = getData<String>('mobileNumber');
    final completer = Completer<bool>();

    Map<String, dynamic> arg = {
      "phone": phoneNumber,
      "countryCode": "91",
      "otp": otp,
    };

    _otpLess.verifyAuth(
      (result) async {
        final isSuccess = await _onHeadlessResult(result);
        if (isSuccess) {
          add(ApiStatusEvent(isLoading: false, hasError: false));
        } else {
          add(ApiStatusEvent(isLoading: false, hasError: true));
        }
        if (completer.isCompleted) return;
        completer.complete(isSuccess);
      },
      arg,
    );

    return completer.future;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
