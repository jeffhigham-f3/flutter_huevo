import 'package:flutter_huevo/core/provider/firestore_collection_provider.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

class UserFirestoreProvider extends FirestoreCollectionProvider<User> {
  const UserFirestoreProvider()
    : super(collectionName: 'users', fromJson: User.fromJson);
}
