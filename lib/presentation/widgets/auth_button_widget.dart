import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({super.key, required this.buttonText, required this.authFunction});
  final String buttonText;
  final Function authFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBg,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),
      ),
      onPressed: () {
        authFunction();
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
