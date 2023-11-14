import 'package:flutter/material.dart';

class AbstractInputWidget extends StatelessWidget {
  final String title;
  final String placeholder;
  final double textPadding;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  AbstractInputWidget({
    required this.title,
    required this.placeholder,
    this.textPadding = 8.0,
    required this.controller,
    this.onChanged,
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
  }) : super(
          title: title,
          placeholder: placeholder,
          textPadding: textPadding,
          controller: controller,
          onChanged: onChanged,
        );
}
