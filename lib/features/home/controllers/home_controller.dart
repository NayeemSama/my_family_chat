import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/auth/repositories/auth_repository.dart';
import 'package:familychat/features/home/repositories/home_repository.dart';
import 'package:familychat/models/chatting_user_info_model.dart';
import 'package:familychat/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider((ref) => HomeController(ref.watch(homeRepositoryProvider), ref));

final chatListProvider = FutureProvider((ref) => ref.watch(homeControllerProvider).getAllChatList());

class HomeController {
  final HomeRepository homeRepository;
  final ProviderRef providerRef;
  List? allChats;

  HomeController(this.homeRepository, this.providerRef) {}

  Future<List<UserModel>?> getAllUsers() async {
    var allUsers = await homeRepository.getAllUsers();
    var u = allUsers.map((e) => UserModel.fromJson(e)).toList();
    u.removeWhere((element) => element.userName == providerRef.read(userDataProvider).value!.userName);
    return u;
  }

  Future<List<ChatUserInfoModel>?> getAllChatList() async {
    allChats = await homeRepository.getUsersChatCollection();
    return allChats?.map((e) => ChatUserInfoModel.fromJson(e)).toList();
  }

  void statusChange({required bool online}) {
    homeRepository.changeOnlineStatus(online);
  }

  void logOut(ctx) {
    providerRef.read(authRepositoryProvider).signOut(ctx);
  }
}
