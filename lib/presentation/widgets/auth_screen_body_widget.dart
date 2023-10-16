import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/text_field_enum.dart';
import 'package:ask_chatgpt/presentation/resources/assets_manager.dart';
import 'package:ask_chatgpt/presentation/resources/routes_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/widgets/auth_button_widget.dart';
import 'package:ask_chatgpt/presentation/widgets/google_button.dart';
import 'package:ask_chatgpt/presentation/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class AuthScreenBodyWidget extends StatefulWidget {
  const AuthScreenBodyWidget({
    super.key,
    required this.isLoginScreen,
    required this.authFunction,
  });
  final bool isLoginScreen;
  final Function authFunction;

  @override
  State<AuthScreenBodyWidget> createState() => _AuthScreenBodyWidgetState();
}

class _AuthScreenBodyWidgetState extends State<AuthScreenBodyWidget> {
  TextEditingController useNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              Form(
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
                        widget.authFunction();
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Wrap(
                        children: [
                          Text(
                            widget.isLoginScreen
                                ? AppStrings.donHaveAccount
                                : AppStrings.alreadyHaveAccount,
                            style: const TextStyle(color: Color(0XFF343541)),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                    const GoogleButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
