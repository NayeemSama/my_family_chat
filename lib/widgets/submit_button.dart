import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onPressed;
  final EdgeInsets? buttonMargin;
  final EdgeInsets? buttonPadding;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final double? buttonWidth;
  final double? buttonHeight;
  final ButtonStyle? elevatedButtonStyle;
  final Widget? child;
  final BorderSide? buttonBorderSide;
  final double? buttonElevation;
  final TextOverflow? textOverflow;
  final bool isButtonWidthNull;
  final bool isButtonHeightNull;

  const SubmitButton({
    Key? key,
    this.buttonText,
    required this.onPressed,
    this.buttonTextStyle,
    this.buttonMargin,
    this.buttonPadding,
    this.borderRadius,
    this.buttonColor,
    this.buttonHeight,
    this.buttonWidth,
    this.elevatedButtonStyle,
    this.child,
    this.buttonBorderSide,
    this.buttonElevation,
    this.textOverflow,
    this.isButtonWidthNull = false,
    this.isButtonHeightNull = false,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: buttonMargin ?? const EdgeInsets.only(left: 20, right: 20),
      height: isButtonHeightNull ? buttonHeight : (buttonHeight ?? 30),
      width: isButtonWidthNull ? buttonWidth : (buttonWidth ?? MediaQuery.of(context).size.width),
      child: ElevatedButton(
        onPressed: onPressed,
        style: elevatedButtonStyle ??
            ElevatedButton.styleFrom(
              elevation: buttonElevation ?? 0,
              padding: buttonPadding ?? EdgeInsets.zero,
              backgroundColor: buttonColor ?? Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                side: buttonBorderSide ?? const BorderSide(style: BorderStyle.none),
              ),
            ),
        child: child ??
            Text(
              buttonText ?? 'Button',
              textAlign: TextAlign.center,
              overflow: textOverflow,
              style: buttonTextStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
            ),
      ),
    );
  }
}
