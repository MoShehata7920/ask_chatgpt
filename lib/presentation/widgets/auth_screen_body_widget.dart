import 'package:ask_chatgpt/presentation/service/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/auth_status.dart';
import 'package:ask_chatgpt/presentation/constants/enums/process_status.dart';
import 'package:ask_chatgpt/presentation/constants/enums/text_field_enum.dart';
import 'package:ask_chatgpt/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:ask_chatgpt/presentation/manager/google_auth_cubit/google_auth_cubit.dart';
import 'package:ask_chatgpt/presentation/manager/sign_in_cubit/sign_in_cubit.dart';
import 'package:ask_chatgpt/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/widgets/auth_button_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/google_button.dart';
import 'package:ask_chatgpt/presentation/widgets/loading_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/text_form_field_widget.dart';

class AuthScreenBodyWidget extends StatefulWidget {
  const AuthScreenBodyWidget({
    super.key,
    required this.isLoginScreen,
  });
  final bool isLoginScreen;

  @override
  State<AuthScreenBodyWidget> createState() => _AuthScreenBodyWidgetState();
}

class _AuthScreenBodyWidgetState extends State<AuthScreenBodyWidget> {
  TextEditingController useNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // sign in
        BlocListener<SignInCubit, SignInState>(listener: (context, state) {
          if (state.status == ProcessStatus.loading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.status == ProcessStatus.error) {
            GlobalMethods.errorDialog(
              context: context,
              title: 'An error occurred! ${state.error.errorMessage}!',
            );
          }
        }),

        // sign up
        BlocListener<SignUpCubit, SignUpState>(listener: (context, state) {
          if (state.status == ProcessStatus.loading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.status == ProcessStatus.error) {
            GlobalMethods.errorDialog(
              context: context,
              title: 'An error occurred! ${state.error.errorMessage}!',
            );
          }
        }),

        // google auth
        BlocListener<GoogleAuthCubit, GoogleAuthState>(
            listener: (context, state) {
          if (state.status == ProcessStatus.loading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.status == ProcessStatus.error) {
            GlobalMethods.errorDialog(
              context: context,
              title: 'An error occurred! ${state.error.errorMessage}!',
            );
          }
        }),

        // auth bloc
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state.authStatus == AuthStatus.authenticated) {
            Navigator.pushNamed(context, Routes.chatScreenRoute);
          }
        }),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 18.0,
            left: 18.0,
            top: MediaQuery.of(context).padding.top,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.logo2, width: 150),
                const SizedBox(height: 50),
                Text(
                  widget.isLoginScreen
                      ? AppStrings.welcomeBack
                      : AppStrings.createAccount,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                !isLoading
                    ? Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormFieldWidget(
                              controller: emailController,
                              textFieldEnum: TextFieldEnum.email,
                              hintText: AppStrings.emailHint,
                              label: AppStrings.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            !widget.isLoginScreen
                                ? TextFormFieldWidget(
                                    controller: useNameController,
                                    textFieldEnum: TextFieldEnum.userName,
                                    hintText: AppStrings.userNameHint,
                                    label: AppStrings.userName,
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(height: widget.isLoginScreen ? 0 : 10),
                            TextFormFieldWidget(
                              controller: passwordController,
                              textFieldEnum: TextFieldEnum.password,
                              hintText: '********',
                              label: AppStrings.password,
                            ),
                            const SizedBox(height: 20),
                            AuthButtonWidget(
                              buttonText: widget.isLoginScreen
                                  ? AppStrings.login
                                  : AppStrings.singUp,
                              authFunction: () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (widget.isLoginScreen) {
                                  context.read<SignInCubit>().handleSignIn(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                      );
                                } else {
                                  context.read<SignUpCubit>().handleSignUp(
                                        email: emailController.text,
                                        username: useNameController.text,
                                        password: passwordController.text,
                                        context: context,
                                      );
                                }
                              },
                              formKey: _formKey,
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Wrap(
                                children: [
                                  Text(
                                    widget.isLoginScreen
                                        ? AppStrings.donHaveAccount
                                        : AppStrings.alreadyHaveAccount,
                                    style: const TextStyle(
                                        color: Color(0XFF343541)),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          widget.isLoginScreen
                                              ? Routes.signUpRoute
                                              : Routes.loginRoute);
                                    },
                                    child: Text(
                                      widget.isLoginScreen
                                          ? AppStrings.singUp
                                          : AppStrings.login,
                                      style: const TextStyle(color: btnBg),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey)),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    AppStrings.or,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            GoogleButton(
                              googleAuthFunction: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isLoading = true;
                                });
                                context
                                    .read<GoogleAuthCubit>()
                                    .handleGoogleAuth();
                              },
                            ),
                          ],
                        ),
                      )
                    : const Center(child: LoadingWidget(size: 50))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
