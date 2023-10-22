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
    required this.likeFunction,
    required this.disLikeFunction,
  }) : super(key: key);

  final Size size;
  final String text;
  final String imgUrl;
  final bool isUser;
  final Function editFunction, copyFunction, likeFunction, disLikeFunction;

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
        title: Text(
          text,
          textAlign: TextAlign.justify,
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
                        likeFunction();
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
                        disLikeFunction();
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
