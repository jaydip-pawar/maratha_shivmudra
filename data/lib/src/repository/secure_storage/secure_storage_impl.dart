import 'dart:io';

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
  Future<bool> isUserLoggedIn() async {
    return _getAndClear();
  }

  Future<bool> _getAndClear() async {
    if (kIsWeb) {
      return await read(key: SecuredStorageConstants.login) == "true";
    }
    if (Platform.isIOS) {
      final prefs = await SharedPreferences.getInstance();
      final isLogin = prefs.getBool(SecuredStorageConstants.sharedLogin);
      if (isLogin != null && isLogin) {
        return true;
      } else {
        return false;
      }
    } else {
      return await read(key: SecuredStorageConstants.login) == "true";
    }
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    _flutterSecureStorage.deleteAll();
    prefs.clear();
  }
}
