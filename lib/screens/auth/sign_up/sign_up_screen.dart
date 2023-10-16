import 'package:ask_chatgpt/resources/routes_manager.dart';
import 'package:ask_chatgpt/resources/strings_manager.dart';
import 'package:ask_chatgpt/widgets/auth_screen_body_widget.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBodyWidget(
        greetingText: AppStrings.createAccount,
        navigationText: AppStrings.alreadyHaveAccount,
        navigationButtonText: AppStrings.login,
        navigationRouteName: Routes.loginRoute,
        authButtonText: AppStrings.singUp,
        authFunction: () {},
      ),
    );
  }
}
