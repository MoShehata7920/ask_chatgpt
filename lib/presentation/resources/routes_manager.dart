import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/screens/auth/login/login_screen.dart';
import 'package:ask_chatgpt/presentation/screens/auth/sign_up/sign_up_screen.dart';
import 'package:ask_chatgpt/presentation/screens/home/home_screen.dart';
import 'package:ask_chatgpt/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signUp";
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
