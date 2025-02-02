import 'package:data/src/util/network_constant.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) {
    return RetrofitService(dio, baseUrl: baseUrl);
  }

  @POST(NetworkConstant.products)
  Future<List<ArticleModel>> getArticles();
}
