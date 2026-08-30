import 'package:data/src/constants/secured_storage_constants.dart';
import 'package:domain/domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SecureStorage)
class SecureStorageImpl implements SecureStorage {
  final _flutterSecureStorage = const FlutterSecureStorage(
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
    await write(key: SecuredStorageConstants.login, value: value.toString());
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final mobile = await getMobileNumber();
    return mobile.trim().isNotEmpty;
  }

  @override
  Future<void> clear() async {
    await _flutterSecureStorage.deleteAll();
  }

  @override
  Future<String> getMobileNumber() async {
    return (await read(key: SecuredStorageConstants.mobileNumber)).trim();
  }

  @override
  Future<void> setMobileNumber(String mobileNumber) async {
    await write(
      key: SecuredStorageConstants.mobileNumber,
      value: mobileNumber.trim(),
    );
  }

  @override
  Future<void> setFormSubmitted(bool value) async {
    await write(key: 'is_form_submitted', value: value.toString());
  }

  @override
  Future<bool> isFormSubmitted() async {
    return (await read(key: 'is_form_submitted')) == "true";
  }
}
