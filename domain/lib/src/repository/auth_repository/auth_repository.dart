import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<Either<NetworkError, TwoFactorModel>> sendOTP(String mobile);

  Future<Either<NetworkError, TwoFactorModel>> verifyOTP({
    required String sessionId,
    required String otp,
  });
}
