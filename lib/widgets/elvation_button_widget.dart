import 'package:flutter/material.dart';

class ElevationButtonWidget extends StatelessWidget {
  const ElevationButtonWidget(
      {super.key, required this.buttonText, required this.buttonFunction});
  final String buttonText;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF16A281)),
      onPressed: () {
        buttonFunction();
      },
      child: Text(buttonText),
    );
  }
}
