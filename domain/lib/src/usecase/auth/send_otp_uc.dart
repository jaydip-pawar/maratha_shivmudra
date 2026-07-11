import 'package:domain/domain.dart';

class SendOTPUseCase
    extends BaseUseCase<NetworkError, SendOtpUseCaseParams, TwoFactorModel> {
  final AuthRepository _authRepository;

  SendOTPUseCase(this._authRepository);

  @override
  Future<Either<NetworkError, TwoFactorModel>> execute(SendOtpUseCaseParams params) {
    return _authRepository.sendOTP(params.mobile);
  }
}

class SendOtpUseCaseParams extends Params {
  SendOtpUseCaseParams(this.mobile);

  final String mobile;

  @override
  Map<String, dynamic> toJson() {
    return {'mobile': mobile};
  }
}
