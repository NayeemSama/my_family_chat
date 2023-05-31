import 'dart:convert';

class UserModel {
  final String uid;
  final String userName;
  final String profilePic;
  final String email;
  final bool isOnline;
  final List groupId;

  UserModel({
    required this.uid,
    required this.userName,
    required this.profilePic,
    required this.email,
    required this.isOnline,
    required this.groupId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      userName: json["userName"],
      profilePic: json["profilePic"],
      email: json["email"],
      isOnline: json["isOnline"] == true,
      groupId: jsonDecode(json["groupId"]).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "userName": userName,
      "profilePic": profilePic,
      "email": email,
      "isOnline": isOnline,
      "groupId": jsonEncode(groupId),
    };
  }
}
