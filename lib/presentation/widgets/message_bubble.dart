import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ask_chatgpt/presentation/constants/enums/operation_type.dart';
import 'package:ask_chatgpt/presentation/resources/icons_manager.dart';
import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.imgUrl,
    required this.size,
    required this.text,
    required this.isUser,
    required this.editFunction,
    required this.copyFunction,
    required this.toggleIsLiked,
    required this.completionId,
    required this.isLiked,
    required this.operationType,
    required this.isFirstRun,
    required this.indexPosition,
    required this.messageLength,
  }) : super(key: key);

  final Size size;
  final String text, imgUrl, completionId;
  final bool isUser, isLiked, isFirstRun;
  final int indexPosition, messageLength;
  final Function editFunction, copyFunction, toggleIsLiked;
  final OperationType operationType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isUser ? primaryColor : accentColor,
      child: ListTile(
        leading: isUser
            ? CircleAvatar(
                backgroundColor: btnBg,
                backgroundImage: NetworkImage(imgUrl),
              )
            : CircleAvatar(
                backgroundColor: btnBg,
                backgroundImage: AssetImage(imgUrl),
              ),
        title: isUser
            ? Text(
                text.trim(),
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.5,
                ),
              )
            : !isFirstRun && indexPosition == messageLength - 1
                ? AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    totalRepeatCount: 0,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        text.trim(),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text.trim(),
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
        trailing: SizedBox(
          width: size.width / 5,
          child: isUser
              // edit
              ? GestureDetector(
                  onTap: () {
                    editFunction();
                  },
                  child: const Icon(
                    AppIcons.editMessage,
                    size: 22,
                    color: Colors.white,
                  ),
                )
              : Row(
                  children: [
                    // copy content
                    GestureDetector(
                      onTap: () {
                        copyFunction();
                      },
                      child: const Icon(
                        AppIcons.copyMessage,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),

                    // like
                    GestureDetector(
                      onTap: () {
                        toggleIsLiked(
                          id: completionId,
                          value: true,
                          operationType: operationType,
                        );
                      },
                      child: const Icon(
                        AppIcons.likeMessage,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),

                    // dislike
                    GestureDetector(
                      onTap: () {
                        toggleIsLiked(
                          id: completionId,
                          value: false,
                          operationType: operationType,
                        );
                      },
                      child: const Icon(
                        AppIcons.disLikeMessage,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
