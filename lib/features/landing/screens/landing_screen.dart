import 'package:familychat/services/paths.dart';
import 'package:familychat/utils/dimensions.dart';
import 'package:familychat/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, Paths.emailScreen);
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimen = Dimensions.create(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: dimen.w * 0.1),
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.only(top: dimen.h * 0.07),
              child: const Text('Welcome to FamilyChat!', style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
            SizedBox(
              height: dimen.h * 0.4,
              width: dimen.h * 0.4,
              child: ClipOval(
                  child: Image.network(
                      'https://img.freepik.com/free-vector/vector-social-contact-seamless-pattern-white-blue_1284-41919.jpg?w=740&t=st=1684753283~exp=1684753883~hmac=642f646aa10c374a8c0fa4e3df56bb7c1e75248e4638357448868c6ef5980884')),
            ),
            Container(
              padding: EdgeInsets.only(bottom: dimen.h * 0.05),
              child: Column(
                children: [
                  const Text(
                    'Read my privacy policy. Tap \'Agree & Continue\' to accept the terms of Service',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: SubmitButton(
                        onPressed: () {
                          navigateToLogin(context);
                        },
                        buttonText: 'AGREE AND CONTINUE',
                        buttonHeight: dimen.h * 0.07),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
