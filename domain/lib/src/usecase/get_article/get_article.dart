import 'package:domain/src/model/article/article_model.dart';
import 'package:domain/src/model/error/network_error.dart';
import 'package:domain/src/repository/article_repository/article_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:domain/src/utils/either.dart';

class GetArticleUseCase
    extends BaseUseCase<NetworkError, GetArticleParams, List<ArticleModel>> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<Either<NetworkError, List<ArticleModel>>> execute(
      GetArticleParams params) {
    return _articleRepository.getArticles();
  }
}

class GetArticleParams extends Params {
  GetArticleParams({required this.category});

  final String category;

  @override
  Map<String, dynamic> toJson() {
    return {"": category};
  }
}
