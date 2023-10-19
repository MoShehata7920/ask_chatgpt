import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, required this.googleAuthFunction})
      : super(key: key);
  final Function googleAuthFunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
      ),
      onPressed: () {
        googleAuthFunction();
      },
      child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        Image.asset(
          ImageAssets.googleImage,
          width: 30,
        ),
        const SizedBox(width: 10),
        const Text(
          AppStrings.signInGoogle,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ]),
    );
  }
}
