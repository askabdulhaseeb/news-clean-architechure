import 'package:flutter/material.dart';

import '../../../domain/entities/article_entity.dart';
import '../../../domain/usercases/get_saved_article.dart';
import '../../../domain/usercases/remove_article.dart';
import '../../../domain/usercases/save_article.dart';

class LocalArticleProvider extends ChangeNotifier {
  LocalArticleProvider(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  );

  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  bool _isLoading = false;
  List<ArticleEntity> articles = <ArticleEntity>[];

  bool get isLoading => _isLoading;
  GetSavedArticleUseCase get getSavedArticleUseCase => _getSavedArticleUseCase;
  SaveArticleUseCase get saveArticleUseCase => _saveArticleUseCase;
  RemoveArticleUseCase get removeArticleUseCase => _removeArticleUseCase;

  void _updateLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> onGetSavedArticles() async {
    _updateLoading(true);
    articles = await _getSavedArticleUseCase.call();
    _updateLoading(false);
  }

  void onRemoveArticle(ArticleEntity value) async {
    await _removeArticleUseCase.call(params: value);
    onGetSavedArticles();
  }

  void onSaveArticle(ArticleEntity value) async {
    await _saveArticleUseCase.call(params: value);
    onGetSavedArticles();
  }
}
