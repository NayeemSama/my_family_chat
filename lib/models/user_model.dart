import 'dart:convert';

class UserModel {
  final String uid;
  final String userName;
  final String profilePic;
  final String email;
  final bool isOnline;
  final String fcmToken;
  final List groupId;

  UserModel({
    required this.uid,
    required this.userName,
    required this.profilePic,
    required this.email,
    required this.fcmToken,
    required this.isOnline,
    required this.groupId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      userName: json["userName"],
      profilePic: json["profilePic"],
      email: json["email"],
      fcmToken: json["fcmToken"],
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
      "fcmToken": fcmToken,
      "isOnline": isOnline,
      "groupId": jsonEncode(groupId),
    };
  }
}
