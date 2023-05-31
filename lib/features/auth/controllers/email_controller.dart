import 'package:familychat/features/auth/repositories/auth_repository.dart';
import 'package:familychat/services/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailControllerProvider = Provider((ref) => EmailController(ref.watch(authRepositoryProvider)));

final userDataProvider = FutureProvider((ref) => ref.watch(authRepositoryProvider).getCurrentUserData());

class EmailController {
  final AuthRepository authRepository;
  String? email;
  String? password;

  EmailController(this.authRepository);

  signUp(BuildContext ctx) {
    print('signInWithEmail controller');
    authRepository.signUp(ctx, email!, password!);
  }

  navigateToLogin(ctx) {
    Navigator.popAndPushNamed(
      ctx,
      Paths.loginScreen,
    );
  }
}
