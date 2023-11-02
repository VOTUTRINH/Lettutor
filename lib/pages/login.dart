import 'package:flutter/material.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class AbstractInputWidget extends StatelessWidget {
  final String title;
  final String placeholder;
  final double textPadding;

  AbstractInputWidget({
    required this.title,
    required this.placeholder,
    this.textPadding = 8.0,
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
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              // Set the border
              borderRadius:
                  BorderRadius.circular(10.0), // Set the border radius
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
    double textPadding = 8.0, // Custom padding value
  }) : super(
          title: title,
          placeholder: placeholder,
          textPadding: textPadding,
        );
}

class LoginPage extends StatelessWidget {
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
    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
              child: (Column(
                children: [
                  Container(
                      child: Image.asset('assets/images/thumbnail_login.png'),
                      margin: EdgeInsets.only(bottom: 30)),
                  Container(
                      padding: EdgeInsets.fromLTRB(vw6, vw4, vw6, vw4),
                      child: Column(
                        children: [
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5),
                              EdgeInsets.fromLTRB(9, 7, 0, 7)),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomTextInputWidget(
                              title: 'MAIL',
                              placeholder: 'mail@example.com',
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: CustomTextInputWidget(
                                title: 'PASSWORD',
                                placeholder: '',
                              )),
                          Container(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: text(
                                      "Forgot Password? ",
                                      TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(0, 113, 240, 1),
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                      EdgeInsets.only(bottom: 14)))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 44,
                              child: Row(children: [
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ListTutorsPage(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF0071F0)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                      color: Color(0xFF0071F0),
                                      width: 1.5,
                                    )),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                              ])),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        "Or continue with?",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                        ...[
                          'assets/images/facebook-logo.svg',
                          'assets/images/google-logo.svg',
                          'assets/images/mobile-logo.svg'
                        ]
                            .map((e) => Row(
                                  children: [
                                    SvgPicture.asset(
                                      e,
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ))
                            .toList()
                      ]))),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Text("Not a member yet?"),
                            Text("Sign up",
                                style: TextStyle(
                                  color: Colors.blue,
                                ))
                          ])))
                ],
              ))),
        ));
  }
}
