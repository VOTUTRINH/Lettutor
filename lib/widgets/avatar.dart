import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  CircularImage({required this.imageUrl, this.size = 70.0});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl ??
            "https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg",
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.network(
              width: size,
              height: size,
              "https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg");
        },
      ),
    );
  }
}
