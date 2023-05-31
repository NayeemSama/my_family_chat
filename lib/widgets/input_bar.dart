import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final String titleText;
  final String hintText;
  final int? textLength;
  final bool isHidden;
  final TextInputType? keyboardType;
  final FormFieldValidator<String?> validator;
  final FormFieldValidator<String?> onSubmit;

  const InputBar({
    Key? key,
    required this.titleText,
    required this.hintText,
    required this.validator,
    required this.onSubmit,
    this.isHidden = false,
    this.keyboardType,
    this.textLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.2,
          child: Text(
            titleText,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        const SizedBox(
          width: 25,
          child: Text(
            ':',
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          width: size.width * 0.6,
          child: TextFormField(
            validator: validator,
            onFieldSubmitted: onSubmit,
            maxLength: textLength,
            keyboardType: keyboardType ?? TextInputType.name,
            obscureText: isHidden,
            textCapitalization: TextCapitalization.words,
            cursorColor: AppColors.borderColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              hintText: hintText,
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.borderColorWhite, width: 4, style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.borderColor, width: 4, style: BorderStyle.solid),
              ),
            ),
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ],
    );
  }
}
