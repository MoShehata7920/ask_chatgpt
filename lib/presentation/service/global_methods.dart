import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';

class GlobalMethods {
  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function function,
    required String warningIcon,
    required BuildContext context,
    dynamic navigateTo,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: 30, height: 30, child: Lottie.asset(warningIcon)),
                const SizedBox(
                  width: 2,
                ),
                Flexible(
                    child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            content: Text(
              subtitle,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    AppStrings.cancel,
                    style: TextStyle(color: Colors.cyan, fontSize: 16),
                  )),
              TextButton(
                  onPressed: () {
                    function();
                    Navigator.pop(context);

                    // Check the type of navigateTo and navigate accordingly
                    if (navigateTo is String) {
                      Navigator.pushReplacementNamed(context, navigateTo);
                    } else if (navigateTo is Function) {
                      navigateTo();
                    }
                  },
                  child: const Text(
                    AppStrings.yes,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ))
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String title,
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Lottie.asset(JsonAssets.error)),
                const SizedBox(
                  width: 2,
                ),
                Flexible(
                    child: Text(
                  AppStrings.errorOccurred,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            content: Text(
              title,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.ok,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  )),
            ],
          );
        });
  }

  static Future<void> verifyAlertDialog({
    required String title,
    required String subtitle,
    required bool isTWoButtons,
    String? theOtherButtonTitle,
    Function? theOtherButtonFunction,
    required BuildContext context,
    dynamic navigateTo,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Lottie.asset(JsonAssets.emailVerification)),
                const SizedBox(
                  width: 2,
                ),
                Flexible(
                    child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            content: Text(
              subtitle,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.ok,
                    style: const TextStyle(color: Colors.cyan, fontSize: 16),
                  )),
              isTWoButtons
                  ? TextButton(
                      onPressed: () {
                        theOtherButtonFunction!();
                        Navigator.pop(context);

                        // Check the type of navigateTo and navigate accordingly
                        if (navigateTo is String) {
                          Navigator.pushReplacementNamed(context, navigateTo);
                        } else if (navigateTo is Function) {
                          navigateTo();
                        }
                      },
                      child: Text(
                        theOtherButtonTitle!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ))
                  : const SizedBox()
            ],
          );
        });
  }
}
