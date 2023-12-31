import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/service/animation.dart';
import 'package:ask_chatgpt/presentation/widgets/elevation_button_widget.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        overflow: TextOverflow.ellipsis);

    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.logoWhite, width: 100).animateOnPageLoad(
              msDelay: 300, dx: 0.0, dy: -70.0, showDelay: 300),
          const SizedBox(height: 15),
          Text(AppStrings.welcomeText, style: style).animateOnPageLoad(
              msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 300),
          const SizedBox(height: 15),
          Text(
            AppStrings.logText,
            style: style,
            maxLines: 2,
            textAlign: TextAlign.center,
          ).animateOnPageLoad(msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 300),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevationButtonWidget(
              buttonText: AppStrings.login,
              buttonFunction: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 300),
            const SizedBox(width: 15),
            ElevationButtonWidget(
              buttonText: AppStrings.singUp,
              buttonFunction: () {
                Navigator.pushReplacementNamed(context, Routes.signUpRoute);
              },
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 300),
          ])
        ],
      ),
    );
  }
}
