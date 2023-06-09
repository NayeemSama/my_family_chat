import 'package:familychat/features/chat/screens/chat_screen.dart';
import 'package:familychat/models/chatting_user_info_model.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/utils/const_keys.dart';
import 'package:familychat/utils/transitions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactsList extends StatelessWidget {
  // final List<UserModel> userList;
  final List<ChatUserInfoModel> userList;

  const ContactsList({Key? key, required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    SlideRightRoute(
                      widget: UserChatScreen(
                        uid: userList[index].contactId,
                        name: userList[index].name,
                        pic: userList[index].profilePic,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Hero(
                      tag: userList[index].name,
                      child: Text(
                        userList[index].name,
                        style: const TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        userList[index].lastMessage,
                        style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        userList[index].profilePic,
                      ),
                      radius: 30,
                    ),
                    trailing: Text(
                      DateFormat('hh:mm a').format(userList[index].timeSent).toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
