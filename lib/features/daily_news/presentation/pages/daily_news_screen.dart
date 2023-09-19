import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/article_entity.dart';
import '../providers/remote/remote_article_provider.dart';
import '../widgets/article_tile.dart';

class DailyNewsScreen extends StatelessWidget {
  const DailyNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DailyNewsScreen')),
      body: _body(),
    );
  }

  Widget _body() {
    return Consumer<RemoteArticleProvider>(
      builder: (BuildContext context, RemoteArticleProvider raPro, _) {
        if (raPro.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (raPro.exception != null && raPro.artciles.isEmpty) {
          return Center(
            child: Text(raPro.exception?.message ?? 'null'),
          );
        } else {
          final List<ArticleEntity> artciles = raPro.artciles;
          return ListView.builder(
            itemCount: artciles.length,
            itemBuilder: (BuildContext context, int index) => ArticleTile(
              artciles[index],
              onArticlePressed: (ArticleEntity article) =>
                  _onArticlePressed(context, article),
            ),
          );
        }
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
