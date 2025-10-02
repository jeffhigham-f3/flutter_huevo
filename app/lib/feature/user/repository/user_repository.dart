import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/core/provider/item_provider.dart';
import 'package:flutter_huevo/feature/auth/provider/auth_provider.dart';
import 'package:flutter_huevo/feature/storage/provider/firebase_storage_provider.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';
import 'package:flutter_huevo/feature/user/model/user_goal.dart';
import 'package:flutter_huevo/feature/user/provider/user_cloud_functions_provider.dart';

class UserRepository with RepositoryLoggy {
  UserRepository({
    required this.userProvider,
    required this.authProvider,
    required this.storageProvider,
    required this.cloudFunctions,
  });

  final ItemProvider<User> userProvider;
  final AuthProvider authProvider;
  final FirebaseStorageProvider storageProvider;
  final UserCloudFunctionsProvider cloudFunctions;

  Stream<User?> getUserStream() {
    StreamSubscription<User?>? userSubscription;
    final transformer = StreamTransformer<String?, User?>.fromHandlers(
      handleData: (userId, output) {
        userSubscription?.cancel();
        if (userId == null) {
          output.add(null);
          return;
        }

        userSubscription = userProvider.getStream(userId).listen(output.add);
      },
    );

    return authProvider.getUserIdStream().transform(transformer);
  }

  Future<void> logOut() {
    return authProvider.logOut();
  }

  Future<bool> uploadPhoto({
    required String userId,
    required String filePath,
    required Uint8List bytes,
  }) async {
    final photoUrl = await storageProvider.uploadUserPhoto(
      userId: userId,
      filePath: filePath,
      bytes: bytes,
    );

    loggy.info('uploadPhoto - photoUrl: $photoUrl');

    if (photoUrl == null) {
      return false;
    }

    return cloudFunctions.setUserPhoto(imageUrl: photoUrl);
  }

  Future<bool> deleteAccount() {
    return cloudFunctions.deleteAccount();
  }

  Future<bool> setOnboardingCompleted({required List<UserGoal> goals}) {
    return cloudFunctions.setOnboardingCompleted(
      goals: goals.map((e) => e.id).toList(),
    );
  }

  Future<bool> setTimezone(String timezone) {
    return cloudFunctions.setTimezone(timezone: timezone);
  }
}
