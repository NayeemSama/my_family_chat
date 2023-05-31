import 'package:familychat/features/chat/screens/chat_screen.dart';
import 'package:familychat/models/chatting_user_info_model.dart';
import 'package:familychat/utils/colors.dart';
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
        shrinkWrap: true,
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserChatScreen(uid: userList[index].contactId),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      userList[index].name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        userList[index].lastMessage,
                        style: const TextStyle(fontSize: 15),
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
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(color: AppColors.dividerColor, indent: 85),
            ],
          );
        },
      ),
    );
  }
}
