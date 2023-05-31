import 'package:familychat/features/auth/repositories/auth_repository.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/services/paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginController(authRepository: authRepository);
});

class LoginController {
  final AuthRepository authRepository;
  String? email;
  String? password;

  LoginController({
    required this.authRepository,
  });

  signInWithPhone(BuildContext ctx) {
    print('signInWithPhone controller');
    authRepository.signInWithEmail(ctx, email!, password!);
  }

  validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void navigateToEmail(BuildContext ctx) {
    Navigator.popAndPushNamed(
      ctx,
      Paths.emailScreen,
    );
  }
}
