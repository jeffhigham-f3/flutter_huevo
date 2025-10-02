import 'package:rxdart/rxdart.dart';
import 'package:flutter_huevo/core/provider/item_provider.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';
import 'package:flutter_huevo/feature/article/provider/article_cloud_functions_provider.dart';
import 'package:flutter_huevo/feature/article/provider/article_dio_provider.dart';
import 'package:flutter_huevo/feature/article/provider/article_firestore_provider.dart';
import 'package:flutter_huevo/feature/auth/provider/auth_provider.dart';

class ArticleRepository {
  ArticleRepository({
    required this.remoteProvider,
    required this.localProvider,
    required this.httpProvider,
    required this.articleCloudFunctions,
    required this.authProvider,
  });

  final ArticleFirestoreProvider remoteProvider;
  final ItemProvider<Article> localProvider;
  final ArticleDioProvider httpProvider;
  final ArticleCloudFunctionsProvider articleCloudFunctions;
  final AuthProvider authProvider;

  Stream<List<Article>> getArticlesStream() {
    final remoteStream = authProvider.createUserStream(
      onNoUser: () => const <Article>[],
      stream: remoteProvider.getForUserStream,
    );
    final localStream = localProvider.getAllStream();
    final httpStream = Stream.fromFuture(getHackerNewsArticles());

    return Rx.combineLatest3(
      remoteStream,
      localStream,
      httpStream,
      (remote, local, http) =>
          [...remote, ...local, ...http]
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  Future<bool> add(Article article) {
    return articleCloudFunctions.articleAdd(
      title: article.title,
      subtitle: article.subtitle,
      text: article.text,
    );
  }

  Future<List<Article>> getHackerNewsArticles() async {
    final data = await httpProvider.getArticle(8863);
    return [Article.fromHackerNews(data)];
  }
}
