import 'package:domain/domain.dart';

abstract class ArticleDataSource {
  Future<List<ArticleModel>> getArticles();
}
