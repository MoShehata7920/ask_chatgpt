import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/screens/auth/auth_screen_body_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBodyWidget(
        isLoginScreen: true,
      ),
    );
  }
}
