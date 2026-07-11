import 'package:data/src/source/auth_data_source/auth_ds.dart';
import 'package:data/src/util/safe_api_call.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<Either<NetworkError, TwoFactorModel>> sendOTP(String mobile) {
    return safeApiCall<TwoFactorModel>(authDataSource.sendOTP(mobile));
  }

  @override
  Future<Either<NetworkError, TwoFactorModel>> verifyOTP({
    required String sessionId,
    required String otp,
  }) {
    return safeApiCall<TwoFactorModel>(
      authDataSource.verifyOTP(sessionId: sessionId, otp: otp),
    );
  }
}
