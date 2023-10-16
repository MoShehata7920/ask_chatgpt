import 'package:ask_chatgpt/resources/routes_manager.dart';
import 'package:ask_chatgpt/resources/strings_manager.dart';
import 'package:ask_chatgpt/widgets/auth_screen_body_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBodyWidget(
        greetingText: AppStrings.welcomeBack,
        navigationText: AppStrings.donHaveAccount, 
        navigationButtonText: AppStrings.singUp,
        navigationRouteName: Routes.signUpRoute,
        authButtonText: AppStrings.login,
        authFunction: () {},
      ),
    );
  }
}
