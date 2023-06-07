import 'package:flutter/foundation.dart';

class Logger {
  static var tag = '';
  static var cloud = '☁️';
  static var success = '✅️';
  static var info = '💡';
  static var warning = '🃏️';
  static var error = '💔';

  static var logIcon = '✏️';

  static void printLog({var tag = 'dialavet', var printLog = '', var logIcon = 'ℹ️️'}) {
    if (true) {
      Logger.logIcon = logIcon;
      Logger.tag = tag;
      if (kDebugMode) {
        print('${Logger.logIcon}----------------------${Logger.logIcon}');
        print(tag + '\t : ' + printLog);
        print('------------------------------------------------------------------');
      }
    }
  }
}
