import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/screens/inner_screen/inner_screen_body.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InnerScreenBody(isChatScreen: true);
  }
}
