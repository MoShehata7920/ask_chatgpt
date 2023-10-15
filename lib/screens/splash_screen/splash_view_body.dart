import 'dart:async';
import 'package:ask_chatgpt/resources/assets_manager.dart';
import 'package:ask_chatgpt/resources/routes_manager.dart';
import 'package:ask_chatgpt/resources/strings_manager.dart';
import 'package:ask_chatgpt/service/animation.dart';
import 'package:ask_chatgpt/service/utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          SizedBox(
            height: size.height * 0.34,
            child: Lottie.asset(JsonAssets.splash).animateOnPageLoad(
                msDelay: 150, dx: 0.0, dy: -200.0, showDelay: 900),
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * 0.45,
              ),
              const Text(
                AppStrings.developedBy,
                style: TextStyle(
                  color: Color(0xFF00BCD4),
                  fontSize: 18,
                ),
              ).animateOnPageLoad(
                  msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppStrings.mohamedShehata,
                style: TextStyle(
                  color: Color(0xFF707099),
                  fontSize: 16,
                ),
              ).animateOnPageLoad(
                  msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToHome() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, Routes.homeRoute));
  }
}
