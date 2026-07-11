import 'package:domain/domain.dart';

class VerifyOtpUseCase
    extends BaseUseCase<NetworkError, VerifyOtpUseCaseParams, TwoFactorModel> {
  final AuthRepository _authRepository;

  VerifyOtpUseCase(this._authRepository);

  @override
  Future<Either<NetworkError, TwoFactorModel>> execute(
    VerifyOtpUseCaseParams params,
  ) {
    return _authRepository.verifyOTP(
      sessionId: params.sessionId,
      otp: params.otp,
    );
  }
}

class VerifyOtpUseCaseParams extends Params {
  VerifyOtpUseCaseParams({required this.sessionId, required this.otp});

  final String sessionId;
  final String otp;

  @override
  Map<String, dynamic> toJson() {
    return {'otp_session_id': sessionId, 'otp_entered_by_user': otp};
  }
}
