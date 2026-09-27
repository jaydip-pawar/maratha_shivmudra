import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/utils/storage_platform_stub.dart'
    if (dart.library.js_interop) 'package:maratha_shivmudra/core/utils/storage_platform_web.dart';

class UserSessionService {
  UserSessionService._();
  static final UserSessionService instance = UserSessionService._();

  /// Increment this integer when deploying major breaking updates or database schema migrations.
  /// Any client with a lower version will automatically execute a force destruct on app boot.
  static const int currentSessionVersion = 2;
  static const String sessionVersionKey = 'app_session_version';
  static const String lastDestructKey = 'last_destruct_timestamp';

  final ValueNotifier<bool> isFormSubmittedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentPhoneNotifier = ValueNotifier<String?>(null);

  /// Initializes session, evaluates versioning, checks remote force destruct,
  /// and cross-references database document existence.
  Future<void> init() async {
    try {
      final ss = getIt<SecureStorage>();

      // 1. Check URL query parameters for manual developer/user force reset
      final uri = Uri.base;
      final hasUrlDestruct = uri.queryParameters['destruct'] == 'true' ||
          uri.queryParameters['reset'] == 'true' ||
          uri.queryParameters['fresh'] == 'true' ||
          uri.queryParameters['clear'] == 'true';

      if (hasUrlDestruct) {
        await forceDestruct(reason: 'Explicit URL parameter reset requested (?reset=true)');
        return;
      }

      // 2. Check Local Session Version for Major Breaking Updates
      final storedVersionStr = await ss.read(key: sessionVersionKey);
      final storedVersion = int.tryParse(storedVersionStr) ?? 0;
      if (storedVersion < currentSessionVersion) {
        await forceDestruct(
          reason: 'Major update / session version migration ($storedVersion -> $currentSessionVersion)',
        );
        return;
      }

      // 3. Check Remote Force Destruct signal in Firestore (site_data/app_config)
      try {
        final configSnap = await FirebaseFirestore.instance
            .collection('site_data')
            .doc('app_config')
            .get();
        if (configSnap.exists) {
          final configData = configSnap.data();
          final minVersion = configData?['min_session_version'] as int? ?? 0;
          final remoteForceDestructTs = configData?['force_destruct_timestamp'] as int? ?? 0;
          final storedDestructTsStr = await ss.read(key: lastDestructKey);
          final storedDestructTs = int.tryParse(storedDestructTsStr) ?? 0;

          if (currentSessionVersion < minVersion ||
              (remoteForceDestructTs > 0 && storedDestructTs < remoteForceDestructTs)) {
            await forceDestruct(reason: 'Remote force destruct signal from app_config');
            return;
          }
        }
      } catch (e) {
        debugPrint('Remote app_config check skipped or failed: $e');
      }

      // 4. Verify Local Session vs Firestore DB Document Existence
      final mobile = await ss.getMobileNumber();

      if (mobile.isEmpty) {
        // No stored mobile number => completely fresh unauthenticated state
        isLoggedInNotifier.value = false;
        currentPhoneNotifier.value = null;
        isFormSubmittedNotifier.value = false;
        return;
      }

      // Stored mobile exists: Cross-verify existence with Firestore
      final doc = await FirebaseFirestore.instance
          .collection('members')
          .doc(mobile)
          .get();

      if (!doc.exists) {
        // Document was deleted from Firestore directly!
        // Local flags are phantom/ghost data. Force destruct immediately!
        debugPrint('UserSessionService: User record $mobile does not exist in Firestore. Executing forceDestruct...');
        await forceDestruct(reason: 'Member record does not exist in database (deleted or removed)');
        return;
      }

      final data = doc.data();
      final mem = data?['membership'] is Map ? data!['membership'] as Map : null;
      final isRegistered = (mem?['is_registered'] == true || data?['is_registered'] == true);

      isLoggedInNotifier.value = true;
      currentPhoneNotifier.value = mobile;
      isFormSubmittedNotifier.value = isRegistered;

      await ss.setLoginFlag(true);
      await ss.setFormSubmitted(isRegistered);
    } catch (e) {
      debugPrint('UserSessionService init error: $e');
    }
  }

  /// Completely purges local session, storage flags, and caches to start 100% fresh.
  Future<void> forceDestruct({String reason = 'Manual'}) async {
    debugPrint('🚨 [UserSessionService] FORCE DESTRUCT TRIGGERED: $reason');
    try {
      final ss = getIt<SecureStorage>();
      await ss.clear();

      if (kIsWeb) {
        purgeBrowserStorage();
      }

      // Reset in-memory notifiers immediately
      isLoggedInNotifier.value = false;
      currentPhoneNotifier.value = null;
      isFormSubmittedNotifier.value = false;

      // Mark the current session version and destruct timestamp so we start clean without looping
      await ss.write(key: sessionVersionKey, value: currentSessionVersion.toString());
      await ss.write(
        key: lastDestructKey,
        value: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    } catch (e) {
      debugPrint('UserSessionService forceDestruct error: $e');
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
    await ss.write(key: sessionVersionKey, value: currentSessionVersion.toString());
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
    await forceDestruct(reason: 'User sign out');
  }
}
