import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/home/screens/home_screen.dart';
import 'package:familychat/features/landing/screens/landing_screen.dart';
import 'package:familychat/firebase_options.dart';
import 'package:familychat/services/awesome_services.dart';
import 'package:familychat/services/firebase_services.dart';
import 'package:familychat/services/router.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/widgets/error_screen.dart';
import 'package:familychat/widgets/loader.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key', androidProvider: AndroidProvider.playIntegrity);
  FirebaseMessaging.onBackgroundMessage(FireMessaging.firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print('onmessage');
    FireMessaging.firebaseMessagingForegroundHandler(event);
  });
  await FirebaseMessaging.instance.getToken().then((value) {
    FireMessaging.setToken(value);
  });
  FirebaseMessaging.instance.onTokenRefresh.map((event) => FireMessaging.refreshToken);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  AwesomeService.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(color: AppColors.appBarColor)),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataProvider).when(
        data: (user) {
          if (user == null) {
            return const LandingScreen();
          } else {
            print('Current User -> ${user.userName}');
            return const HomeScreen();
          }
        },
        error: (error, stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () => const Loader(),
      ),
    );
  }
}
