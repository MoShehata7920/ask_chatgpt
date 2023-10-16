import 'package:ask_chatgpt/constants/colors.dart';
import 'package:flutter/material.dart';

class ElevationButtonWidget extends StatelessWidget {
  const ElevationButtonWidget(
      {super.key, required this.buttonText, required this.buttonFunction});
  final String buttonText;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: btnBg),
      onPressed: () {
        buttonFunction();
      },
      child: Text(buttonText),
    );
  }
}
