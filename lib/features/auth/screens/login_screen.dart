import 'package:familychat/features/auth/controllers/login_controller.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/widgets/input_bar.dart';
import 'package:familychat/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/loginScreen';

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
          title: const Text('Login'),
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
                    validator: (String? value) {
                      return ref.read(loginControllerProvider).validateName(value!);
                    },
                    onSubmit: (value) {
                      return ref.read(loginControllerProvider).email = value;
                    },
                  ),
                  InputBar(
                    titleText: 'Pass-word ',
                    hintText: '*****',
                    isHidden: true,
                    keyboardType: TextInputType.phone,
                    textLength: 13,
                    validator: (String? value) {
                      return ref.read(loginControllerProvider).validateName(value!);
                    },
                    onSubmit: (value) {
                      return ref.read(loginControllerProvider).password = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.borderColor, padding: EdgeInsets.symmetric(horizontal: 30)),
                onPressed: () {
                  ref.read(loginControllerProvider).navigateToEmail(context);
                },
                child: const Text('Register', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom != 0.0,
              child: const SizedBox(
                height: 50,
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
              child: SubmitButton(
                onPressed: () {
                  ref.read(loginControllerProvider).signInWithPhone(context);
                  print('signInWithPhone login');
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
