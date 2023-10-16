import 'package:ask_chatgpt/presentation/constants/colors.dart';
import 'package:ask_chatgpt/presentation/constants/enums/text_field_enum.dart';
import 'package:ask_chatgpt/presentation/resources/icons_manager.dart';
import 'package:ask_chatgpt/presentation/resources/strings_manager.dart';
import 'package:ask_chatgpt/presentation/service/functions.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.textFieldEnum,
      required this.hintText,
      required this.label});
  final TextEditingController controller;
  final TextFieldEnum textFieldEnum;
  final String hintText, label;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: widget.controller,
      autofocus: widget.textFieldEnum == TextFieldEnum.email ? true : false,
      obscureText: widget.textFieldEnum == TextFieldEnum.password
          ? isPasswordObscured
          : false,
      validator: (value) {
        if (value!.isEmpty) {
          return '${widget.label} ${AppStrings.cantBeEmpty}';
        }
        switch (widget.textFieldEnum) {
          case TextFieldEnum.email:
            if (!value.isValidEmail()) {
              return AppStrings.notValidEmail;
            }
            break;

          case TextFieldEnum.password:
            if (value.length < 8) {
              return AppStrings.notValidPassword;
            }
            break;

          case TextFieldEnum.userName:
            if (value.isEmpty) {
              return AppStrings.notValidName;
            }
            break;
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: widget.textFieldEnum == TextFieldEnum.password
            ? widget.controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: () => setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    }),
                    child: Icon(
                        isPasswordObscured
                            ? AppIcons.notVisible
                            : AppIcons.visible,
                        color: btnBg),
                  )
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        label: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade500,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
