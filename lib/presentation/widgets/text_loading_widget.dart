import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TextLoading extends StatelessWidget {
  const TextLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(
      color: btnBg,
      size: 40,
    );
  }
}
