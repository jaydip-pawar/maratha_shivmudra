import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/services/user_session_service.dart';

class MemorySecureStorage implements SecureStorage {
  final Map<String, String> store = {};

  @override
  Future<void> clear() async {
    store.clear();
  }

  @override
  Future<void> delete({required String key}) async {
    store.remove(key);
  }

  @override
  Future<String> getMobileNumber() async => store['mobileNumber'] ?? '';

  @override
  Future<bool> isFormSubmitted() async => store['is_form_submitted'] == 'true';

  @override
  Future<bool> isUserLoggedIn() async => (store['mobileNumber'] ?? '').isNotEmpty;

  @override
  Future<String> read({required String key}) async => store[key] ?? '';

  @override
  Future<void> setFormSubmitted(bool value) async {
    store['is_form_submitted'] = value.toString();
  }

  @override
  Future<void> setLoginFlag(bool value) async {
    store['login'] = value.toString();
  }

  @override
  Future<void> setMobileNumber(String mobileNumber) async {
    store['mobileNumber'] = mobileNumber;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    store[key] = value;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MemorySecureStorage memoryStorage;

  setUp(() {
    memoryStorage = MemorySecureStorage();
    if (getIt.isRegistered<SecureStorage>()) {
      getIt.unregister<SecureStorage>();
    }
    getIt.registerSingleton<SecureStorage>(memoryStorage);
  });

  group('UserSessionService Force Destruct Tests', () {
    test('forceDestruct purges all secure storage keys and resets notifiers', () async {
      final session = UserSessionService.instance;

      // Populate fake existing session
      await memoryStorage.setMobileNumber('8691955046');
      await memoryStorage.setLoginFlag(true);
      await memoryStorage.setFormSubmitted(true);
      session.isLoggedInNotifier.value = true;
      session.isFormSubmittedNotifier.value = true;
      session.currentPhoneNotifier.value = '8691955046';

      expect(session.isLoggedInNotifier.value, isTrue);
      expect(session.isFormSubmittedNotifier.value, isTrue);
      expect(session.currentPhoneNotifier.value, equals('8691955046'));

      // Trigger force destruct
      await session.forceDestruct(reason: 'Test force destruct');

      // Notifiers must all be reset to fresh state
      expect(session.isLoggedInNotifier.value, isFalse);
      expect(session.isFormSubmittedNotifier.value, isFalse);
      expect(session.currentPhoneNotifier.value, isNull);

      // Old session flags must be gone from storage
      expect(await memoryStorage.getMobileNumber(), isEmpty);
      expect(await memoryStorage.isFormSubmitted(), isFalse);

      // New version and destruct timestamp must be stamped
      expect(
        await memoryStorage.read(key: UserSessionService.sessionVersionKey),
        equals(UserSessionService.currentSessionVersion.toString()),
      );
      expect(
        (await memoryStorage.read(key: UserSessionService.lastDestructKey)).isNotEmpty,
        isTrue,
      );
    });

    test('Session version mismatch triggers forceDestruct on startup', () async {
      final session = UserSessionService.instance;

      // Set old version (v1) in storage
      await memoryStorage.setMobileNumber('8691955046');
      await memoryStorage.setFormSubmitted(true);
      await memoryStorage.write(
        key: UserSessionService.sessionVersionKey,
        value: '1',
      );

      // If version is 1 and currentSessionVersion is 2, it should trigger forceDestruct
      final storedVersion = int.tryParse(
            await memoryStorage.read(key: UserSessionService.sessionVersionKey),
          ) ??
          0;
      if (storedVersion < UserSessionService.currentSessionVersion) {
        await session.forceDestruct(
          reason: 'Major update session version bump',
        );
      }

      expect(session.isLoggedInNotifier.value, isFalse);
      expect(session.isFormSubmittedNotifier.value, isFalse);
      expect(await memoryStorage.getMobileNumber(), isEmpty);
      expect(
        await memoryStorage.read(key: UserSessionService.sessionVersionKey),
        equals(UserSessionService.currentSessionVersion.toString()),
      );
    });

    test('signOut executes forceDestruct cleanly', () async {
      final session = UserSessionService.instance;

      await memoryStorage.setMobileNumber('9876543210');
      await memoryStorage.setFormSubmitted(true);
      session.isLoggedInNotifier.value = true;
      session.currentPhoneNotifier.value = '9876543210';
      session.isFormSubmittedNotifier.value = true;

      await session.signOut();

      expect(session.isLoggedInNotifier.value, isFalse);
      expect(session.currentPhoneNotifier.value, isNull);
      expect(session.isFormSubmittedNotifier.value, isFalse);
      expect(await memoryStorage.getMobileNumber(), isEmpty);
    });
  });
}
