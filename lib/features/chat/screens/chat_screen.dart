import 'dart:ui';

import 'package:familychat/features/call/controller/call_controller.dart';
import 'package:familychat/features/call/screens/call_pickup_screen.dart';
import 'package:familychat/features/chat/controller/chat_controller.dart';
import 'package:familychat/features/chat/widgets/bottom_field.dart';
import 'package:familychat/features/chat/widgets/chat_list.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/utils/asset_keys.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/utils/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class UserChatScreen extends ConsumerWidget {
  final String uid;
  final String name;
  final String pic;

  const UserChatScreen({Key? key, required this.uid, required this.name, required this.pic}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.08 + MediaQuery.of(context).viewPadding.top),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            color: Colors.white,
            child: StreamBuilder<UserModel>(
                stream: ref.read(chatControllerProvider).getUsersDetails(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.03,
                        horizontal: size.width * 0.08,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  height: size.width * 0.1,
                                  width: size.width * 0.1,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: AppColors.darkBackground,
                                  )),
                            ),
                          ),
                          Hero(
                            tag: snapshot.data!.userName,
                            child: Text(
                              snapshot.data!.userName,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkBackground,
                              ),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(callControllerProvider)
                                    .makeCall(context, name, uid, pic, ConstKeys.videoCall, false);
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: size.width * 0.1,
                                width: size.width * 0.1,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.call,
                                  color: AppColors.darkBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                    color: Colors.white),
                child: ChatList(receiverId: uid),
              ),
            ),
            BottomChatField(recieverUserId: uid),
          ],
        ),
      ),
    );
  }
}
//AppBar(
//           backgroundColor: AppColors.appBarColor,
//           title: StreamBuilder<UserModel>(
//               stream: ref.read(chatControllerProvider).getUsersDetails(uid),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const SizedBox();
//                 }
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       snapshot.data!.userName,
//                       style: const TextStyle(fontSize: 22),
//                     ),
//                     snapshot.data!.isOnline == true
//                         ? const Text(
//                             'Online',
//                             style: TextStyle(fontSize: 12),
//                           )
//                         : const SizedBox(),
//                   ],
//                 );
//               }),
//           titleSpacing: 0,
//           centerTitle: false,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 ref.read(callControllerProvider).makeCall(context, name, uid, pic, ConstKeys.videoCall, false);
//               },
//               icon: const Icon(Icons.video_call),
//             ),
//             IconButton(
//               onPressed: () {
//                 ref.read(callControllerProvider).makeCall(context, name, uid, pic, ConstKeys.audioCall, false);
//               },
//               icon: const Icon(Icons.call),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.more_vert),
//             ),
//           ],
//         )
