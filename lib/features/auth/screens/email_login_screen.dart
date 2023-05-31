import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/widgets/input_bar.dart';
import 'package:familychat/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailLoginScreen extends ConsumerWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: size.height * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputBar(
                    titleText: 'Email ',
                    hintText: 'Eg. asd@asd.com',
                    keyboardType: TextInputType.emailAddress,
                    textLength: 13,
                    validator: (String? value) {},
                    onSubmit: (value) {
                      return ref.read(emailControllerProvider).email = value;
                    },
                  ),
                  InputBar(
                    titleText: 'Pass-word ',
                    hintText: '*****',
                    isHidden: true,
                    keyboardType: TextInputType.text,
                    textLength: 13,
                    validator: (String? value) {},
                    onSubmit: (value) {
                      return ref.read(emailControllerProvider).password = value;
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom != 0.0,
              child: const SizedBox(
                height: 50,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.borderColor, padding: EdgeInsets.symmetric(horizontal: 30)),
                onPressed: () {
                  ref.read(emailControllerProvider).navigateToLogin(context);
                },
                child: const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
              child: SubmitButton(
                onPressed: () {
                  ref.read(emailControllerProvider).signUp(context);
                  print('signInWithPhone email');
                },
                buttonText: 'Continue',
                buttonColor: AppColors.submitButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
