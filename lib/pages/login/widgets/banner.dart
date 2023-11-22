import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class BannerV extends StatelessWidget {
  Widget text(content, style, margin) {
    return Container(
        margin: margin,
        child: Text(
          content,
          style: style,
          textAlign: TextAlign.center,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double vw4 = MediaQuery.of(context).size.width * 0.04;
    double vw6 = MediaQuery.of(context).size.width * 0.06;
    return Column(children: [
      Container(
          child: Image.asset('assets/images/thumbnail_login.png'),
          margin: EdgeInsets.only(bottom: 30)),
      Container(
          padding: EdgeInsets.fromLTRB(vw6, vw4, vw6, vw4),
          child: Column(children: [
            text(
                "Say hello to your English tutors",
                TextStyle(
                    fontSize: 28,
                    color: Color.fromRGBO(0, 113, 240, 1),
                    fontWeight: FontWeight.w600,
                    height: 1.5),
                EdgeInsets.only(bottom: 14)),
            text(
                "Become fluent faster through one on one video chat lessons tailored to your goals.",
                TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500, height: 1.5),
                EdgeInsets.fromLTRB(9, 7, 0, 7)),
          ]))
    ]);
  }
}
