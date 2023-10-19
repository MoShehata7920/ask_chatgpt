import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget(
      {super.key,
      required this.buttonText,
      required this.authFunction,
      required this.formKey});
  final String buttonText;
  final Function authFunction;
  final GlobalKey<FormState> formKey;

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
        handleAuth(context, formKey);
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  void handleAuth(BuildContext context, GlobalKey<FormState> formKey) {
    FocusScope.of(context).unfocus();
    var valid = formKey.currentState!.validate();
    if (!valid) {
      return;
    } else {
      authFunction();
    }
  }
}
