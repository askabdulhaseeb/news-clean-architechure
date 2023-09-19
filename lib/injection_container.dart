import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/daily_news/data/repository/article_repository_imp.dart';
import 'features/daily_news/data/sources/local/app_database.dart';
import 'features/daily_news/data/sources/remote/news_api_service.dart';
import 'features/daily_news/domain/repository/article_repository.dart';
import 'features/daily_news/domain/usercases/get_acticle.dart';
import 'features/daily_news/domain/usercases/get_saved_article.dart';
import 'features/daily_news/domain/usercases/remove_article.dart';
import 'features/daily_news/domain/usercases/save_article.dart';
import 'features/daily_news/presentation/providers/local/local_article_provider.dart';
import 'features/daily_news/presentation/providers/remote/remote_article_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton<Dio>(Dio());

  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);

  //
  // SINGLETON
  //
  // Daily Artile
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));
  getIt.registerSingleton<ArticleRepository>(
      ArticleRepositoryImp(getIt(), getIt()));

  getIt.registerSingleton<GetArticleUseCase>(GetArticleUseCase(getIt()));
  getIt.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(getIt()));
  getIt.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(getIt()));
  getIt.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(getIt()));

  //
  // PROVIDERS
  //
  // Daily Artile
  getIt.registerFactory<RemoteArticleProvider>(
    () => RemoteArticleProvider(getIt()),
  );
  getIt.registerFactory<LocalArticleProvider>(
    () => LocalArticleProvider(getIt(), getIt(), getIt()),
  );
}
