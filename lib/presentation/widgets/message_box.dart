import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/resources/icons_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';

class MessageBoxWidget extends StatelessWidget {
  const MessageBoxWidget({
    Key? key,
    required this.textController,
    required this.size,
    required this.generateResponse,
    required this.isTyping,
  }) : super(key: key);
  final Size size;
  final TextEditingController textController;
  final Function generateResponse;
  final bool isTyping;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF0C385D),
        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 3,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      height: size.height / 15,
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          hintText: AppStrings.sendMessage,
          hintStyle: const TextStyle(color: hintColor),
          suffixIcon: GestureDetector(
            onTap: () => isTyping ? null : generateResponse(),
            child: const Icon(
              AppIcons.send,
              color: hintColor,
            ),
          ),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
