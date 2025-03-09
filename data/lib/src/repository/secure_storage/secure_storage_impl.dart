import 'package:data/src/constants/secured_storage_constants.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  final _flutterSecureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'IMobile_Key:',
      preferencesKeyPrefix: 'IMobile_Encrypted_Key:',
    ),
  );

  @override
  Future<void> write({required String key, required String value}) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String> read({required String key}) async {
    return await _flutterSecureStorage.read(key: key) ?? "";
  }

  @override
  Future<void> setLoginFlag(bool value) async {
    if (kIsWeb) {
      await write(key: SecuredStorageConstants.login, value: value.toString());
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _getAndClear();
  }

  Future<bool> _getAndClear() async {
    return await read(key: SecuredStorageConstants.login) == "true";
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    _flutterSecureStorage.deleteAll();
    prefs.clear();
  }

  @override
  Future<String> getMobileNumber() async {
    return await read(key: SecuredStorageConstants.mobileNumber);
  }

  @override
  Future<void> setMobileNumber(String mobileNumber) async {
    await write(key: SecuredStorageConstants.mobileNumber, value: mobileNumber);
  }
}
