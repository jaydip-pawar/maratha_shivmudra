import 'package:data/src/util/network_constant.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {
  factory RetrofitService(
    Dio dio, {
    String? baseUrl,
  }) = _RetrofitService;

  @POST(NetworkConstant.products)
  Future<List<ArticleModel>> getArticles();

  @GET('${NetworkConstant.twoFactorBaseUrl}{mobile}/AUTOGEN/OTP1')
  Future<TwoFactorModel> sendOTP(
    @Path('mobile') String mobile,
  );

  @GET('${NetworkConstant.twoFactorBaseUrl}VERIFY/{sessionId}/{otp}')
  Future<TwoFactorModel> verifyOTP(
    @Path('sessionId') String sessionId,
    @Path('otp') String otp,
  );
}
