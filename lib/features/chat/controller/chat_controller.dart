import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/auth/repositories/auth_repository.dart';
import 'package:familychat/features/chat/repositories/chat_repository.dart';
import 'package:familychat/models/message_model.dart';
import 'package:familychat/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider =
    Provider((ref) => ChatController(ref.watch(authRepositoryProvider), ref.watch(chatRepositoryProvider), ref));

class ChatController {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  final ProviderRef providerRef;

  ChatController(this.authRepository, this.chatRepository, this.providerRef);

  Stream<UserModel> getUsersDetails(userId) {
    return authRepository.userData(userId);
  }

  Stream<List<MessageModel>> getAllMessages(receiverId) {
    return providerRef.read(chatRepositoryProvider).getChatStream(receiverId);
  }

  sendMessage(BuildContext ctx, String message, String receiverId, bool isGroup) {
    providerRef.read(userDataProvider).whenData((value) => chatRepository.sendTextMessage(
          context: ctx,
          text: message,
          recieverUserId: receiverId,
          senderUser: value!,
          isGroupChat: isGroup,
        ));
  }
}
