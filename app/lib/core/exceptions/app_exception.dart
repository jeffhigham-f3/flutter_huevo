import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/widgets.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/logger/logger.dart';

enum AppException implements Exception {
  // Auth
  wrongPassword,
  tooManyRequests,
  invalidEmailAddress,
  emailInUse,
  accountDoesNotExist,
  weakPassword,

  // Other
  unknown;

  const AppException();

  factory AppException.createAndLog(String tag, dynamic e, StackTrace s) {
    final exception = AppException._create(e);

    if (exception == AppException.unknown) {
      // Log unknown exceptions
      logError('[$tag] unknown error: $e', e, s);
    } else {
      logInfo('[$tag] $exception');
    }

    return exception;
  }

  factory AppException._create(dynamic e) {
    return switch (e) {
      AppException() => e,
      auth.FirebaseAuthException() => switch (e.code) {
        'wrong-password' => wrongPassword,
        'too-many-requests' => tooManyRequests,
        'invalid-email' => invalidEmailAddress,
        'email-already-in-use' => emailInUse,
        'user-not-found' => accountDoesNotExist,
        'weak-password' => weakPassword,
        _ => unknown,
      },
      _ => unknown,
    };
  }

  String getText(BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      // Auth
      AppException.wrongPassword => l10n.errorWrongPassword,
      AppException.tooManyRequests => l10n.errorTooManyRequests,
      AppException.invalidEmailAddress => l10n.errorInvalidEmailAddress,
      AppException.emailInUse => l10n.errorEmailAlreadyInUse,
      AppException.accountDoesNotExist => l10n.errorAccountNotExist,
      AppException.weakPassword => l10n.errorWeakPassword,

      // Other
      AppException.unknown => l10n.errorUnknownError,
    };
  }
}
