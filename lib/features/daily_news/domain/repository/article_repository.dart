import 'package:newapp/core/resources/data_state.dart';
import 'package:newapp/features/daily_news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
