import 'package:flutter_huevo/core/bloc/value_stream_cubit.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';
import 'package:flutter_huevo/feature/article/repository/article_repository.dart';

class ArticlesCubit extends ValueStreamCubit<List<Article>> {
  ArticlesCubit({required this.articleRepository});

  final ArticleRepository articleRepository;

  @override
  Stream<List<Article>> getValueStream() =>
      articleRepository.getArticlesStream();
}
