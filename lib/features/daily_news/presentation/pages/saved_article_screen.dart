import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/article_entity.dart';
import '../providers/local/local_article_provider.dart';
import '../widgets/article_tile.dart';

class SavedArticlesScreen extends HookWidget {
  const SavedArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalArticleProvider>(
      builder: (BuildContext context, LocalArticleProvider laPro, _) =>
          Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.arrow_back_sharp, color: Colors.black),
        ),
      ),
      title:
          const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return Consumer<LocalArticleProvider>(
      builder: (BuildContext context, LocalArticleProvider laPro, _) {
        if (laPro.isLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (laPro.articles.isNotEmpty) {
          return _buildArticlesList(laPro.articles);
        }
        return const Center(child: Text('EMPTY'));
      },
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED ARTICLES',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        return ArticleTile(
          articles[index],
          isRemovable: true,
          onRemove: (ArticleEntity article) =>
              _onRemoveArticle(context, article),
          onArticlePressed: (ArticleEntity article) =>
              _onArticlePressed(context, article),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemoveArticle(BuildContext context, ArticleEntity article) {
    Provider.of<LocalArticleProvider>(context, listen: false)
        .onRemoveArticle(article);
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
