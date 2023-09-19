// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _NewsApiService implements NewsApiService {
  _NewsApiService(this._dio, {String? baseUrl}) {
    baseUrl = baseUrl ?? 'https://newsapi.org/v2';
    _dio.options.baseUrl = baseURL;
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<ArticleModel>>> getNewsAtricles({
    String? apiKey,
    String? country,
  }) async {
    log('Request Started...');
    const Map<String, dynamic> _extra = <String, dynamic>{};
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      r'apiKey': apiKey,
      r'country': country,
    };
    queryParameters.removeWhere((String k, dynamic v) => v == null);
    final Map<String, dynamic> _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final Response<Map<String, dynamic>> _result =
        await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<HttpResponse<List<ArticleModel>>>(Options(
        method: 'GET',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            '/top-headlines',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ),
          )),
    );
    log('Request: ${_result.data!['status']}');
    List<ArticleModel> value = _result.data!['articles']
        .map<ArticleModel>(
            (dynamic i) => ArticleModel.fromJson(i as Map<String, dynamic>))
        .toList();
    log('Article length: ${value.length}');
    final HttpResponse<List<ArticleModel>> httpResponse =
        HttpResponse<List<ArticleModel>>(value, _result);
    log('Done...');
    log('httpResponse: ${httpResponse.response.realUri.path}');
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final Uri url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
