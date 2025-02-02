import 'package:domain/src/model/article/article_model.dart';
import 'package:domain/src/model/error/network_error.dart';
import 'package:domain/src/utils/either.dart';

abstract class ArticleRepository {
  Future<Either<NetworkError, List<ArticleModel>>> getArticles();
}
