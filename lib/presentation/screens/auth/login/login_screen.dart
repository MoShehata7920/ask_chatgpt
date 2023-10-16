import 'package:ask_chatgpt/presentation/widgets/auth_screen_body_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBodyWidget(
        isLoginScreen: true,
        authFunction: () {},
      ),
    );
  }
}
