import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/screens/auth/login/login_screen.dart';
import 'package:ask_chatgpt/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:ask_chatgpt/presentation/screens/inner_screen/chat/chat_screen.dart';
import 'package:ask_chatgpt/presentation/screens/choose_type/choose_type_screen.dart';
import 'package:ask_chatgpt/presentation/screens/inner_screen/completion/completion_screen.dart';
import 'package:ask_chatgpt/presentation/screens/home/home_screen.dart';
import 'package:ask_chatgpt/presentation/screens/splash_screen/splash_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signUp";
  static const String chatScreenRoute = "/chatScreen";
  static const String chooseTypeScreenRoute = "/chooseTypeScreen";
  static const String completionScreenRoute = "/completionScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (context) => const SingUpScreen());

      case Routes.chatScreenRoute:
        return MaterialPageRoute(builder: (context) => const ChatScreen());

      case Routes.chooseTypeScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ChooseTypeScreen());

      case Routes.completionScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const CompletionScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteTitle),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
