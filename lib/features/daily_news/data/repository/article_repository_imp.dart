import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/consts.dart';
import '../models/article_model.dart';
import '../../domain/repository/article_repository.dart';
import '../sources/remote/news_api_service.dart';

class ArticleRepositoryImp extends ArticleRepository {
  ArticleRepositoryImp(this._newsApiService);
  final NewsApiService _newsApiService;

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final HttpResponse<List<ArticleModel>> httpResponce =
          await _newsApiService.getNewsAtricles(
        apiKey: apiKey,
        category: 'general',
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
}
