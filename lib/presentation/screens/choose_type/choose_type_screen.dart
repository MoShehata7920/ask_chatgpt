import 'package:ask_chatgpt/presentation/widgets/elevation_button_widget.dart';
import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';

class ChooseTypeScreen extends StatelessWidget {
  const ChooseTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // navigate to completion
    void navigateToCompletion() {
      Navigator.pushReplacementNamed(context, Routes.completionScreenRoute);
    }

    // navigate to chat screen
    void navigateToChat() {
      Navigator.pushReplacementNamed(context, Routes.chatScreenRoute);
    }

    // style for text
    TextStyle style = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.logoWhite, width: 100),
          const SizedBox(height: 10),
          Text(AppStrings.chooseTypeText, style: style),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevationButtonWidget(
                buttonText: 'Chat',
                buttonFunction: () {
                  navigateToChat();
                },
              ),
              const SizedBox(width: 10),
              ElevationButtonWidget(
                buttonText: 'Completion',
                buttonFunction: () {
                  navigateToCompletion();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
