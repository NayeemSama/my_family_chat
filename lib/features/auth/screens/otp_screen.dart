import 'package:familychat/widgets/input_bar.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Enter the otp!!!'),
          InputBar(
            titleText: 'OTP ',
            hintText: '1234',
            validator: (value) {},
            onSubmit: (String? value) {},
          )
        ],
      ),
    );
  }
}
