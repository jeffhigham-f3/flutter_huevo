import 'dart:async';

typedef NoUserCallback<T> = T Function();
typedef StreamForUserCallback<T> = Stream<T> Function(String userId);

abstract class AuthProvider {
  /// Returns current user id, if successful.
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Returns current user id, if successful.
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String?> signInWithGoogle();

  Future<String?> signInWithApple();

  Future<String?> signInAnonymously();

  Stream<String?> getUserIdStream();

  String? getUserId();

  Future<void> logOut();

  Future<void> resetPassword(String email);

  Stream<T> createUserStream<T>({
    required NoUserCallback<T> onNoUser,
    required StreamForUserCallback<T> stream,
  }) {
    StreamSubscription<T>? subscription;
    final transformer = StreamTransformer<String?, T>.fromHandlers(
      handleData: (userId, output) {
        subscription?.cancel();
        if (userId == null) {
          output.add(onNoUser());
          return;
        }

        subscription = stream(userId).listen(output.add);
      },
    );

    return getUserIdStream().transform(transformer);
  }
}
