import 'package:flutter_huevo/core/firebase/cloud_functions_provider.dart';
import 'package:flutter_huevo/core/firebase/cloud_functions_response.dart';

class UserCloudFunctionsProvider extends CloudFunctionsProvider {
  Future<bool> setUserPhoto({required String imageUrl}) {
    return call(CloudFunctions.setUserPhoto, {
      'imageUrl': imageUrl,
    }).toSuccessOrThrow();
  }

  Future<bool> addUserFcmToken({required String token}) {
    return call(CloudFunctions.addUserFcmToken, {
      'token': token,
    }).toSuccessOrThrow();
  }

  Future<bool> removeUserFcmToken({required String token}) {
    return call(CloudFunctions.removeUserFcmToken, {
      'token': token,
    }).toSuccessOrThrow();
  }

  Future<bool> sendUserNotification() {
    return call(CloudFunctions.sendUserNotification).toSuccessOrThrow();
  }

  Future<bool> deleteAccount() {
    return call(CloudFunctions.deleteAccount).toSuccessOrThrow();
  }

  Future<bool> setOnboardingCompleted({required List<String> goals}) {
    return call(CloudFunctions.userSetOnboardingCompleted, {
      'goals': goals,
    }).toSuccessOrThrow();
  }

  Future<bool> setTimezone({required String timezone}) {
    return call(CloudFunctions.userSetTimezone, {
      'timezone': timezone,
    }).toSuccessOrThrow();
  }
}
