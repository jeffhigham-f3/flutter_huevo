import 'package:flutter_huevo/core/bloc/single_action_cubit.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/repository/analytics_repository.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';
import 'package:flutter_huevo/feature/article/repository/article_repository.dart';

class ArticleAddCubit extends SingleActionCubit {
  ArticleAddCubit({
    required this.articleRepository,
    required this.analyticsRepository,
  });

  final ArticleRepository articleRepository;
  final AnalyticsRepository analyticsRepository;

  void add(Article article) {
    doAction(
      () => articleRepository.add(article),
      onSuccess: () =>
          analyticsRepository.logEvent(AnalyticsEvent.articleAdded),
    );
  }
}
