import 'package:flutter_huevo/feature/settings/provider/feedback_cloud_functions_provider.dart';

class FeedbackRepository {
  final _cloudFunctions = FeedbackCloudFunctionsProvider();

  Future<bool> sendFeedback({required String email, required String message}) {
    return _cloudFunctions.sendFeedback(email: email, message: message);
  }
}
