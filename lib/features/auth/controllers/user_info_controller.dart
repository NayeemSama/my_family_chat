import 'package:familychat/features/auth/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usercontrollerProvider = Provider((ref) {
  return UserInfoController(ref.watch(authRepositoryProvider), ref);
});

class UserInfoController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  String? name;
  String? surname;
  String? familyName;

  UserInfoController(this.authRepository, this.ref);

  saveUserDataToFirebase(context, name, image) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: image,
      ref: ref,
      context: context,
    );
  }
}
