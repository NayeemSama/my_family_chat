import 'package:familychat/features/auth/screens/email_login_screen.dart';
import 'package:familychat/features/auth/screens/login_screen.dart';
import 'package:familychat/features/auth/screens/otp_screen.dart';
import 'package:familychat/features/auth/screens/user_info_screen.dart';
import 'package:familychat/features/home/screens/home_screen.dart';
import 'package:familychat/features/landing/screens/landing_screen.dart';
import 'package:familychat/screens/mobile_layout_screen.dart';
import 'package:familychat/services/paths.dart';
import 'package:flutter/material.dart';

generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Paths.landingScreen:
      return MaterialPageRoute(builder: (context) => const LandingScreen());
    case Paths.loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case Paths.emailScreen:
      return MaterialPageRoute(builder: (context) => const EmailLoginScreen());
    case Paths.userInfoScreen:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
    case Paths.otpScreen:
      final verifyId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verifyId));
    case Paths.homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    default:
      return MaterialPageRoute(builder: (context) => const MobileLayoutScreen());
  }
}
