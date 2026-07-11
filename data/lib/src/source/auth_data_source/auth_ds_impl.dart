import 'package:data/src/network/retrofit_service.dart';
import 'package:data/src/source/auth_data_source/auth_ds.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this._retrofitService);

  final RetrofitService _retrofitService;

  @override
  Future<TwoFactorModel> sendOTP(String mobile) => _retrofitService.sendOTP(mobile);

  @override
  Future<TwoFactorModel> verifyOTP({required sessionId, required otp}) =>
      _retrofitService.verifyOTP(sessionId, otp);
}
