import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';
import 'features/daily_news/domain/usercases/get_acticle.dart';
import 'features/daily_news/domain/usercases/get_saved_article.dart';
import 'features/daily_news/domain/usercases/remove_article.dart';
import 'features/daily_news/domain/usercases/save_article.dart';
import 'features/daily_news/presentation/pages/daily_news_screen.dart';
import 'features/daily_news/presentation/providers/local/local_article_provider.dart';
import 'features/daily_news/presentation/providers/remote/remote_article_provider.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<RemoteArticleProvider>(
          create: (_) => RemoteArticleProvider(getIt<GetArticleUseCase>()),
        ),
        ChangeNotifierProvider<LocalArticleProvider>(
          create: (_) => LocalArticleProvider(
            getIt<GetSavedArticleUseCase>(),
            getIt<SaveArticleUseCase>(),
            getIt<RemoveArticleUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App - Clean Architechure',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNewsScreen(),
      ),
    );
  }
}

// flutter pub run build_runner build