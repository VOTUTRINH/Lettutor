import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  CircularImage({required this.imageUrl, this.size = 70.0});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover, // You can choose how to fit the image
      ),
    );
  }
}
