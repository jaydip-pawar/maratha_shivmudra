abstract class SecureStorage {
  Future<void> write({required String key, required String value});

  Future<String> read({required String key});

  Future<void> delete({required String key});

  Future<void> setLoginFlag(bool value);

  Future<bool> isUserLoggedIn();

  Future<String> getMobileNumber();

  Future<void> setMobileNumber(String mobileNumber);

  Future<void> clear();
}
