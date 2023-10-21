import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:flutter/material.dart';

class ContainerBg extends StatelessWidget {
  const ContainerBg({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backGroundColor,
        border: Border.all(width: 0, color: backGroundColor),
      ),
      child: child,
    );
  }
}
