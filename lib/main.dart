// ignore_for_file: unused_local_variable

import 'package:ask_chatgpt/data/repositories/api_repo.dart';
import 'package:ask_chatgpt/data/repositories/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ask_chatgpt/data/repositories/repos.dart';
import 'package:ask_chatgpt/firebase_options.dart';
import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/manager/export/cubits_exports.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Config.fetchApiKey();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),

        // API repository
        RepositoryProvider(
          create: (context) => APIRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // auth bloc
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),

          // sign in cubit
          BlocProvider(
            create: (context) => GoogleAuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),

          // sign up cubit
          BlocProvider(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),

          // google auth cubit
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),

          // profile cubit
          BlocProvider(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),

          // open_ai_model cubit
          BlocProvider(
            create: (context) => OpenAiModelCubit(
              apiRepository: context.read<APIRepository>(),
            ),
          ),

          // api_work cubit
          BlocProvider(
            create: (context) => OpenAiCompletionsCubit(
              apiRepository: context.read<APIRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: backGroundColor),
          debugShowCheckedModeBanner: false,
          title: 'Ask ChatGPT',
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
