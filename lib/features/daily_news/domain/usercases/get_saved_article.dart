import '../../../../core/usercases/usecase.dart';
import '../entities/article_entity.dart';
import '../repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  GetSavedArticleUseCase(this._articleRepository);
  
  final ArticleRepository _articleRepository;

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
