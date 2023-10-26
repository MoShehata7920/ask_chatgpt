import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/screens/inner_screen/inner_screen_body.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InnerScreenBody(isChatScreen: false);
  }
}
