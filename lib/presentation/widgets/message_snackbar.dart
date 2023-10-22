import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/status.dart';
import 'package:flutter/material.dart';

void displaySnackBar({
  required Status status,
  required String message,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 350),
      backgroundColor: status == Status.success ? primaryColor : Colors.red,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          Icon(
            status == Status.success
                ? Icons.mood
                : Icons.sentiment_dissatisfied,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}
