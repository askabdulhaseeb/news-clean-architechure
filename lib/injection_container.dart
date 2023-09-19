import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/daily_news/data/repository/article_repository_imp.dart';
import 'features/daily_news/data/sources/remote/news_api_service.dart';
import 'features/daily_news/domain/repository/article_repository.dart';
import 'features/daily_news/domain/usercases/get_acticle.dart';
import 'features/daily_news/presentation/provider/article/remote/remote_article_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton<Dio>(Dio());

  //
  // SINGLETON
  //
  // Daily Artile
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));
  getIt.registerSingleton<ArticleRepository>(ArticleRepositoryImp(getIt()));
  getIt.registerSingleton<GetArticleUseCase>(GetArticleUseCase(getIt()));

  //
  // PROVIDERS
  //
  // Daily Artile
  getIt.registerFactory<RemoteArticleProvider>(
    () => RemoteArticleProvider(getIt()),
  );
}
