import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/utils/consts.dart';
import '../../models/article_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: baseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) => _NewsApiService(dio, baseUrl: baseURL);

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsAtricles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
  });
}
