part of 'single_action_cubit.dart';

@immutable
sealed class SingleActionState {
  const SingleActionState();
}

class SingleActionInitial extends SingleActionState {
  const SingleActionInitial();
}

class SingleActionLoading extends SingleActionState {
  const SingleActionLoading();
}

class SingleActionFailure extends SingleActionState {
  const SingleActionFailure({required this.exception});

  final AppException exception;
}

class SingleActionSuccess extends SingleActionState {
  const SingleActionSuccess();
}
