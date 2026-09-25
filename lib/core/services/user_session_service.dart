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
  final ValueNotifier<String?> currentPhoneNotifier =
      ValueNotifier<String?>(null);

  Future<void> init() async {
    try {
      final ss = getIt<SecureStorage>();
      final mobile = await ss.getMobileNumber();

      final isSubmitted = await ss.isFormSubmitted();

      isLoggedInNotifier.value = mobile.isNotEmpty;
      currentPhoneNotifier.value = mobile.isNotEmpty ? mobile : null;
      isFormSubmittedNotifier.value = isSubmitted;

      // Check Firestore for members record existence
      if (mobile.isNotEmpty) {
        final doc = await FirebaseFirestore.instance
            .collection('members')
            .doc(mobile)
            .get();
        if (doc.exists && doc.data()?['is_registered'] == true) {
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
    currentPhoneNotifier.value = mobile;
    isFormSubmittedNotifier.value = isFormSubmitted;
  }

  Future<void> onFormSubmitted() async {
    final ss = getIt<SecureStorage>();
    await ss.setFormSubmitted(true);
    isFormSubmittedNotifier.value = true;
  }

  Future<void> signOut() async {
    final ss = getIt<SecureStorage>();
    await ss.clear();
    isLoggedInNotifier.value = false;
    currentPhoneNotifier.value = null;
    isFormSubmittedNotifier.value = false;
  }
}
