import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/screens/auth/auth_screen_body_widget.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBodyWidget(
        isLoginScreen: false,
      ),
    );
  }
}
