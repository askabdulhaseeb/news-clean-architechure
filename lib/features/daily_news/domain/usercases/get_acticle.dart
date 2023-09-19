import '../../../../core/resources/data_state.dart';
import '../../../../core/usercases/usercase.dart';
import '../entities/article_entity.dart';
import '../repository/article_repository.dart';

class GetArticleUseCase
    implements UserCase<DataState<List<ArticleEntity>>, void> {
  GetArticleUseCase(this._articleRepository);
  final ArticleRepository _articleRepository;

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
