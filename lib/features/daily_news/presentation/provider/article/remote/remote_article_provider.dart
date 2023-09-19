import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/entities/article_entity.dart';
import '../../../../domain/usercases/get_acticle.dart';

class RemoteArticleProvider extends ChangeNotifier {
  RemoteArticleProvider(this._getArticleUseCase) {
    onGetArticles();
  }

  final GetArticleUseCase _getArticleUseCase;
  List<ArticleEntity> artciles = <ArticleEntity>[];
  DioException? exception;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  _onUpdateLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void onGetArticles() async {
    _onUpdateLoading(true);
    final DataState<List<ArticleEntity>> dataState =
        await _getArticleUseCase.call();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      artciles = dataState.data ?? <ArticleEntity>[];
      exception = null;
    }

    if (dataState is DataFailer) {
      exception = dataState.exception;
    }
    _onUpdateLoading(false);
  }
}
