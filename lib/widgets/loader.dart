import 'dart:ui';

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final color;

  const Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: const ClipRect(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
