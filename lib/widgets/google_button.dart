import 'package:ask_chatgpt/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import '../resources/strings_manager.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

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
      onPressed: () {},
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
