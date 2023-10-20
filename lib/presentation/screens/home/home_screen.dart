import 'package:ask_chatgpt/presentation/constants/enums/auth_status.dart';
import 'package:ask_chatgpt/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/screens/home/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.authStatus == AuthStatus.authenticated) {
            Navigator.pushNamed(context, Routes.chatScreenRoute);
          }
        },
        child: const HomeScreenBody(),
      ),
    );
  }
}
