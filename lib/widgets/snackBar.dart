import 'package:flutter/material.dart';

Future<void> snackBar({required BuildContext context, required String text}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
