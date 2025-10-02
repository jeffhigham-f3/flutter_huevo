import 'package:flutter_huevo/core/bloc/single_action_cubit.dart';
import 'package:flutter_huevo/feature/settings/repository/feedback_repository.dart';

class SendFeedbackCubit extends SingleActionCubit {
  SendFeedbackCubit({required this.feedbackRepository});

  final FeedbackRepository feedbackRepository;

  void sendFeedback({required String email, required String message}) {
    doAction(
      () => feedbackRepository.sendFeedback(email: email, message: message),
    );
  }
}
