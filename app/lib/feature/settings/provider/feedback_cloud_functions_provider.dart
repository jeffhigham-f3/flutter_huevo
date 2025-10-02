import 'package:flutter_huevo/core/firebase/cloud_functions_provider.dart';
import 'package:flutter_huevo/core/firebase/cloud_functions_response.dart';

class FeedbackCloudFunctionsProvider extends CloudFunctionsProvider {
  Future<bool> sendFeedback({required String email, required String message}) {
    return call(CloudFunctions.sendFeedback, {
      'email': email,
      'message': message,
    }).toSuccessOrThrow();
  }
}
