import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/di/di.dart';

class UserSessionService {
  UserSessionService._();
  static final UserSessionService instance = UserSessionService._();

  final ValueNotifier<bool> isFormSubmittedNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(false);

  Future<void> init() async {
    try {
      final ss = getIt<SecureStorage>();
      final mobile = await ss.getMobileNumber();
      final isSubmitted = await ss.isFormSubmitted();

      isLoggedInNotifier.value = mobile.isNotEmpty;
      isFormSubmittedNotifier.value = isSubmitted;

      // If user is logged in, double-check Firestore for form_info existence
      if (mobile.isNotEmpty && !isSubmitted) {
        final doc = await FirebaseFirestore.instance
            .collection(mobile)
            .doc('form_info')
            .get();
        if (doc.exists) {
          await ss.setFormSubmitted(true);
          isFormSubmittedNotifier.value = true;
        }
      }
    } catch (e) {
      debugPrint('UserSessionService init error: $e');
    }
  }

  Future<void> onUserAuthenticated(
    String mobile, {
    bool isFormSubmitted = false,
  }) async {
    final ss = getIt<SecureStorage>();
    await ss.setMobileNumber(mobile);
    await ss.setLoginFlag(true);
    await ss.setFormSubmitted(isFormSubmitted);
    isLoggedInNotifier.value = true;
    isFormSubmittedNotifier.value = isFormSubmitted;
  }

  Future<void> onFormSubmitted() async {
    final ss = getIt<SecureStorage>();
    await ss.setFormSubmitted(true);
    isFormSubmittedNotifier.value = true;
  }
}
