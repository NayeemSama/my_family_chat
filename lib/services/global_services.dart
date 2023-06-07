class GlobalServices {
  static String baseUrl = 'http://54.157.3.39:1337/';
  static String api = '${baseUrl}api/';

  // static String firebaseSendApi = 'https://fcm.googleapis.com/fcm/send';
  static String firebaseSendApi = 'https://fcm.googleapis.com/v1/projects/familychat-55095/messages:send';

  static dynamic getHeaders() async {
    var headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': '',
    };

    // headers['Authorization'] = 'Bearer ${GetStorage().read(AUTHORIZATION_TOKEN)}';
    return headers;
  }
}
