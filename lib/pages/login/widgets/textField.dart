import 'package:flutter/material.dart';

class AbstractInputWidget extends StatelessWidget {
  final String title;
  final String placeholder;
  final double textPadding;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final isPassword;

  AbstractInputWidget({
    required this.title,
    required this.placeholder,
    this.textPadding = 8.0,
    required this.controller,
    this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: textPadding),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          obscureText: isPassword,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextInputWidget extends AbstractInputWidget {
  CustomTextInputWidget({
    required String title,
    required String placeholder,
    double textPadding = 8.0,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    bool isPassword = false,
  }) : super(
          title: title,
          placeholder: placeholder,
          textPadding: textPadding,
          controller: controller,
          onChanged: onChanged,
          isPassword: isPassword,
        );
}
