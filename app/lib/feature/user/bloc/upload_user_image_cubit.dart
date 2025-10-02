import 'dart:typed_data';

import 'package:flutter_huevo/core/bloc/single_action_cubit.dart';
import 'package:flutter_huevo/feature/user/repository/user_repository.dart';

class UploadUserImageCubit extends SingleActionCubit {
  UploadUserImageCubit({required this.userRepository});

  final UserRepository userRepository;

  void upload({
    required Uint8List bytes,
    required String filePath,
    required String userId,
  }) {
    doAction(
      () => userRepository.uploadPhoto(
        userId: userId,
        filePath: filePath,
        bytes: bytes,
      ),
    );
  }
}
