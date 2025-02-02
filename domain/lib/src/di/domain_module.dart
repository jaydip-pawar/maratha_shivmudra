import 'package:domain/src/di/domain_module.config.dart';
import 'package:domain/src/repository/article_repository/article_repository.dart';
import 'package:domain/src/usecase/get_article/get_article.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initDomainModule')
Future<void> $initDomainModule(GetIt getIt) async {
  getIt.initDomainModule();
}

@module
abstract class DomainModule {
  @injectable
  GetArticleUseCase createLocationUseCaseProvider(ArticleRepository repository) {
    return GetArticleUseCase(repository);
  }
}
