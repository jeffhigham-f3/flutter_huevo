import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/bloc/single_action_cubit.dart';
import 'package:flutter_huevo/core/exceptions/app_exception.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/ui/widget/loading_overlay.dart';

class SingleActionBlocListener<T extends SingleActionCubit>
    extends StatelessWidget {
  const SingleActionBlocListener({
    required this.onSuccess,
    required this.child,
    this.onError,
    super.key,
  });

  final VoidCallback onSuccess;
  final ValueChanged<AppException>? onError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<T, SingleActionState>(
      listener: (context, state) {
        if (state is SingleActionSuccess) {
          onSuccess();
        } else if (state is SingleActionFailure) {
          final onError = this.onError;
          if (onError == null) {
            context.showSnackBarMessage(
              state.exception.getText(context),
              isError: true,
            );
            return;
          }

          onError(state.exception);
        }
      },
      builder: (context, state) =>
          LoadingOverlay(loading: state is SingleActionLoading, child: child),
    );
  }
}
