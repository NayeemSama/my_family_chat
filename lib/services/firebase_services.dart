import 'dart:convert';
import 'dart:io';
import 'package:familychat/firebase_options.dart';
import 'package:familychat/models/message_model.dart';
import 'package:familychat/models/notification_model.dart';
import 'package:familychat/services/awesome_services.dart';
import 'package:familychat/services/global_services.dart';
import 'package:familychat/utils/const_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  init() {
    firebaseStorage.setMaxUploadRetryTime(Duration(milliseconds: 500));
  }

  Future<String> storeFileToFirebase(String path, File file) async {
    TaskSnapshot snap = await firebaseStorage.ref().child(path).putFile(file);
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

class FireMessaging {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  ProviderRef? ref;

  static void setToken(token) async {
    print('Firebase Token Set---------------------->');
    print('Token -> $token');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ConstKeys.firebaseToken, token.toString());
  }

  static void refreshToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Firebase Token Refresh---------------------->');
    print('Old -> ${prefs.get(ConstKeys.firebaseToken)}');
    print('New -> $token');
    await prefs.setString(ConstKeys.oldFirebaseToken, prefs.get(ConstKeys.firebaseToken).toString());
    await prefs.setString(ConstKeys.firebaseToken, token.toString());
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(ConstKeys.firebaseToken).toString();
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('Background Message Received---------------------->');
    if (remoteMessage.toMap()['data']['type'] == 'endCall') {
      AwesomeService.dismissNotifications();
    } else {
      AwesomeService.showNotification(
        channel: 'channel',
        from: remoteMessage.toMap()['data']['fromUser'],
        type: remoteMessage.toMap()['data']['type'],
      );
    }
  }

  static Future<void> firebaseMessagingForegroundHandler(RemoteMessage remoteMessage) async {
    print('Foreground Message Received---------------------->');
    print(remoteMessage.toMap().toString());
  }

  static void sendNotification({required String token, required String type, required String from}) async {
    var data = {
      "message": {
        'data': {'type': type, 'fromUser': from, 'sound': 'ringtone.mp3'},
        "token": token
      }
    };

    ///Generate Bearer Token From Google Oauth Playground console
    var headers = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer ya29.a0AWY7CkkZN8yUXe2hbBymZY5QCcAtHGKiYaBt8tfreaf0WgvucMUaYnGdSc-d8ODf0jQwb-S4eIJU-qRDc1e5WV5e7uYGErMzxIBnk6HaUusDcEGvJEIKl0lfJZcNRRQVYH38o1T2xer0RxoiI1VPeUodAQzD3QwaCgYKAUoSARISFQG1tDrpZZziAmaIQbzNBJRR_U2HNA0166"
    };

    http.Response response = await http.post(
      Uri.parse(GlobalServices.firebaseSendApi),
      body: jsonEncode(data),
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );

    print('Status Code :- ${response.request}');
    print('Status Code :- ${response.body}');
    print('Status Code :- ${response.statusCode}');
  }
}
