import 'package:ask_chatgpt/constants/colors.dart';
import 'package:ask_chatgpt/constants/text_field_enum.dart';
import 'package:ask_chatgpt/resources/assets_manager.dart';
import 'package:ask_chatgpt/resources/strings_manager.dart';
import 'package:ask_chatgpt/widgets/auth_button_widget.dart';
import 'package:ask_chatgpt/widgets/google_button.dart';
import 'package:ask_chatgpt/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class AuthScreenBodyWidget extends StatefulWidget {
  const AuthScreenBodyWidget(
      {super.key,
      required this.greetingText,
      required this.navigationText,
      required this.navigationButtonText,
      required this.navigationRouteName,
      required this.authButtonText,
      required this.authFunction});
  final String greetingText,
      navigationText,
      navigationButtonText,
      navigationRouteName,
      authButtonText;
  final Function authFunction;

  @override
  State<AuthScreenBodyWidget> createState() => _AuthScreenBodyWidgetState();
}

class _AuthScreenBodyWidgetState extends State<AuthScreenBodyWidget> {
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
                widget.greetingText,
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
                    TextFormFieldWidget(
                      controller: passwordController,
                      textFieldEnum: TextFieldEnum.password,
                      hintText: '********',
                      label: AppStrings.password,
                    ),
                    const SizedBox(height: 20),
                    AuthButtonWidget(
                      buttonText: widget.authButtonText,
                      authFunction: () {
                        widget.authFunction();
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Wrap(
                        children: [
                          Text(
                            widget.navigationText,
                            style: const TextStyle(color: Color(0XFF343541)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, widget.navigationRouteName);
                            },
                            child: Text(
                              widget.navigationButtonText,
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
