import 'package:flutter/material.dart';

import 'package:ask_chatgpt/presentation/constants/colors.dart';

class ModelDropDownButton extends StatefulWidget {
  const ModelDropDownButton({Key? key}) : super(key: key);

  @override
  State<ModelDropDownButton> createState() => _ModelDropDownButtonState();
}

class _ModelDropDownButtonState extends State<ModelDropDownButton> {
  var selectedModel = 'Mohamed';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: selectedModel,
      style: const TextStyle(color: Colors.white),
      dropdownColor: msgBg,
      iconEnabledColor: btnBg,
      items: const [
        DropdownMenuItem(
          value: 'Mohamed',
          child: Text('Mohamed'),
        ),
        DropdownMenuItem(
          value: 'Ahmed',
          child: Text('Ahmed'),
        ),
        DropdownMenuItem(
          value: 'Ziad',
          child: Text('Ziad'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedModel = value!;
        });
      },
    );
  }
}
