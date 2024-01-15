import 'package:flutter/material.dart';

class FreeContentWidget extends StatelessWidget {
  final String title;

  const FreeContentWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              ' images/folder_empty.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
