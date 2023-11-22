import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Border color
            width: 2.0, // Border width
          ),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/lettutor_logo.svg',
            height: 39,
          ),
        ],
      ),
    );
  }
}
