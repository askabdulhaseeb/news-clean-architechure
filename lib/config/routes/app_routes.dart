import 'package:flutter/material.dart';

import '../../features/daily_news/domain/entities/article_entity.dart';
import '../../features/daily_news/presentation/pages/article_detail_screen.dart';
import '../../features/daily_news/presentation/pages/daily_news_screen.dart';
import '../../features/daily_news/presentation/pages/saved_article_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNewsScreen());
      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetailScreen(article: settings.arguments as ArticleEntity));
      case '/SavedArticles':
        return _materialRoute(const SavedArticlesScreen());
      default:
        return _materialRoute(const DailyNewsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute<dynamic>(builder: (_) => view);
  }
}
