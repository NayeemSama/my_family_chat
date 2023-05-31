class ChatUserInfoModel {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatUserInfoModel(
      {required this.name,
      required this.profilePic,
      required this.contactId,
      required this.timeSent,
      required this.lastMessage});

  factory ChatUserInfoModel.fromJson(Map<String, dynamic> json) {
    return ChatUserInfoModel(
      name: json["name"],
      profilePic: json["profilePic"],
      contactId: json["contactId"],
      timeSent: DateTime.parse(json["timeSent"]),
      lastMessage: json["lastMessage"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePic,
      "contactId": contactId,
      "timeSent": timeSent.toIso8601String(),
      "lastMessage": lastMessage,
    };
  }
}
