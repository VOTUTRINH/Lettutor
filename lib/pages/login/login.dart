import 'package:flutter/material.dart';
import 'package:individual_project/pages/login/widgets/banner.dart';
import 'package:individual_project/pages/login/widgets/textField.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/services/models/account.dart';
import 'package:individual_project/services/respository/account-repository.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  late bool isLogin;

  LoginPage({Key? key, this.isLogin = true}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();

  void setIsLogin(bool isLogin) {
    this.isLogin = isLogin;
  }
}

class _LoginPage extends State<LoginPage> {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    double vw4 = MediaQuery.of(context).size.width * 0.04;
    double vw6 = MediaQuery.of(context).size.width * 0.06;
    AccountRepository accountRepository = context.watch<AccountRepository>();

    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
              child: (Column(
                children: [
                  BannerV(),
                  Container(
                      padding: EdgeInsets.fromLTRB(vw6, vw4, vw6, vw4),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CustomTextInputWidget(
                              title: 'MAIL',
                              placeholder: 'mail@example.com',
                              controller: emailController,
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: CustomTextInputWidget(
                                title: 'PASSWORD',
                                placeholder: '',
                                controller: _textFieldController2,
                                onChanged: (value) {
                                  password = value;
                                },
                              )),
                          if (widget.isLogin)
                            Container(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 14),
                                        child: InkWell(
                                            onTap: () {},
                                            child: Text(
                                              "Forgot Password? ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      0, 113, 240, 1),
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5),
                                            ))))),
                          Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 44,
                              child: Row(children: [
                                Expanded(
                                    child: ElevatedButton(
                                  onPressed: () {
                                    if (widget.isLogin) {
                                      if (accountRepository.isExistedAccount(
                                          email, password)) {
                                        showSnackBar('Login Successful');
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListTutorsPage(),
                                          ),
                                        );
                                      }
                                    } else {
                                      if (!accountRepository.isExistedAccount(
                                          email, password)) {
                                        var account =
                                            new Account(1, email, password);
                                        accountRepository.add(account);
                                      }
                                    }
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
                                    widget.isLogin ? "LOG IN" : "SIGN UP",
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
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.setIsLogin(!widget.isLogin);
                                });
                              },
                              child: Text(widget.isLogin ? "Sign up" : "Log in",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )),
                            )
                          ])))
                ],
              ))),
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    _textFieldController2.dispose();

    super.dispose();
  }
}
