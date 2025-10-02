import 'package:flutter_huevo/core/provider/firestore_collection_provider.dart';
import 'package:flutter_huevo/feature/article/model/article.dart';

class ArticleFirestoreProvider extends FirestoreCollectionProvider<Article> {
  const ArticleFirestoreProvider()
    : super(collectionName: 'articles', fromJson: Article.fromJson);

  Stream<List<Article>> getForUserStream(String userId) {
    return collection
        .where('authorId', isEqualTo: userId)
        .snapshots()
        .map(toItemList);
  }
}
