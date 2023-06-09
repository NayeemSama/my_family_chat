import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColor = Colors.blueGrey;
  static const textColor = Color.fromRGBO(241, 241, 242, 1);
  static const appBarColor = Color(0xBAE6FCFF);
  static const webAppBarColor = Color.fromRGBO(42, 47, 50, 1);
  static const messageColor = Color.fromRGBO(5, 96, 98, 1);
  static const senderMessageColor = Color.fromRGBO(37, 45, 49, 1);
  static const tabColor = Color.fromRGBO(0, 167, 131, 1);
  static const searchBarColor = Color.fromRGBO(50, 55, 57, 1);
  static const dividerColor = Color.fromRGBO(37, 45, 50, 1);
  static const chatBarMessage = Color.fromRGBO(30, 36, 40, 1);
  static const mobileChatBoxColor = Color.fromRGBO(31, 44, 52, 1);

  static const submitButtonColor = Color(0xFF20B0EA);
  static const borderColor = Color(0xff64b5f6);
  static const borderColorWhite = Color(0x8affffff);
  static const bgBlueGrey = Color(0xff85acb0);

  ///New Theme
  static const darkBackground = Color(0xff1c2e46);
  static const darkBackgroundShade1 = Color(0xff28426b);
  static const darkBackgroundShade2 = Color(0x284260FF);
  static Color darkBackgroundShade3 = const Color(0xff1c2e46);

  static const MaterialColor darkPrimary = MaterialColor(
    0xff1c2e46,
    <int, Color>{
      50: Color(0xff1c2e46), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffa04332), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xff733024), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xff2e130e), //80%
      800: Color(0xff170907), //90%
      900: Color(0xff000000), //100%
    },
  );
}
