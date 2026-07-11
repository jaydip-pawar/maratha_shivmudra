import 'package:domain/domain.dart';

abstract class AuthDataSource {
  Future<TwoFactorModel> sendOTP(String mobile);

  Future<TwoFactorModel> verifyOTP({
    required String sessionId,
    required String otp,
  });
}
