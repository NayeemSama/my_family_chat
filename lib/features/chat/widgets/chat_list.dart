import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/chat/controller/chat_controller.dart';
import 'package:familychat/features/chat/widgets/date_seperator.dart';
import 'package:familychat/features/chat/widgets/my_message_card.dart';
import 'package:familychat/features/chat/widgets/sender_message_card.dart';
import 'package:familychat/models/message_model.dart';
import 'package:familychat/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverId;

  const ChatList({
    required this.receiverId,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController chatListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
        stream: ref.read(chatControllerProvider).getAllMessages(widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: const Loader(
                  color: Colors.white,
                ));
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            print('reset');
            chatListController.jumpTo(0);
          });

          return SingleChildScrollView(
            reverse: true,
            child: ListView.builder(
              shrinkWrap: true,
              controller: chatListController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (index != snapshot.data!.length - 1) {
                  if (snapshot.data![index].timeSent.difference(snapshot.data![index + 1].timeSent).inDays < 0) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (snapshot.data![index].senderId == ref.read(userDataProvider).value!.uid)
                          MyMessageCard(
                            message: snapshot.data![index].text.toString(),
                            date: snapshot.data![index].timeSent.toString(),
                          )
                        else
                          SenderMessageCard(
                            message: snapshot.data![index].text.toString(),
                            date: snapshot.data![index].timeSent.toString(),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: DateSeparator(
                                date: snapshot.data![index + 1].timeSent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }
                if (snapshot.data![index].senderId == ref.read(userDataProvider).value!.uid) {
                  return MyMessageCard(
                    message: snapshot.data![index].text.toString(),
                    date: snapshot.data![index].timeSent.toString(),
                  );
                }
                return SenderMessageCard(
                  message: snapshot.data![index].text.toString(),
                  date: snapshot.data![index].timeSent.toString(),
                );
              },
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatListController.dispose();
  }
}
