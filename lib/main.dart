import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'features/daily_news/domain/usercases/get_acticle.dart';
import 'features/daily_news/presentation/pages/daily_news.dart';
import 'features/daily_news/presentation/provider/article/remote/remote_article_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'News App - Clean Architechure',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DailyNewsScreen(),
      ),
    );
  }
}

// flutter pub run build_runner build