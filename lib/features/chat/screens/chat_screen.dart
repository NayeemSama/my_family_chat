import 'package:familychat/features/chat/controller/chat_controller.dart';
import 'package:familychat/features/chat/widgets/bottom_field.dart';
import 'package:familychat/features/chat/widgets/chat_list.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserChatScreen extends ConsumerWidget {
  final String uid;

  const UserChatScreen({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(chatControllerProvider).getUsersDetails(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!.userName,
                    style: const TextStyle(fontSize: 22),
                  ),
                  snapshot.data!.isOnline == true
                      ? const Text(
                          'Online',
                          style: TextStyle(fontSize: 12),
                        )
                      : const SizedBox(),
                ],
              );
            }),
        titleSpacing: 0,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(receiverId: uid),
          ),
          BottomChatField(recieverUserId: uid),
        ],
      ),
    );
  }
}
