import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/consts.dart';
import '../../domain/entities/article_entity.dart';
import '../models/article_model.dart';
import '../../domain/repository/article_repository.dart';
import '../sources/local/app_database.dart';
import '../sources/remote/news_api_service.dart';

class ArticleRepositoryImp extends ArticleRepository {
  ArticleRepositoryImp(this._newsApiService, this._appDatabase);
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final HttpResponse<List<ArticleModel>> httpResponce =
          await _newsApiService.getNewsAtricles(
        apiKey: apiKey,
        country: 'us',
      );

      if (httpResponce.response.statusCode == HttpStatus.ok) {
        return DataSuccess<List<ArticleModel>>(httpResponce.data);
      } else {
        return DataFailer<List<ArticleModel>>(
          DioException(
            error: httpResponce.response.statusMessage,
            response: httpResponce.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponce.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailer<List<ArticleModel>>(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDAO.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
