import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/pages/tutors/list-tutors.dart';
import 'package:individual_project/services/auth.service.dart';
import 'package:provider/provider.dart';

class LoginWith extends StatefulWidget {
  const LoginWith({Key? key}) : super(key: key);

  @override
  _LoginWithState createState() => _LoginWithState();
}

class _LoginWithState extends State<LoginWith> {
  late GoogleSignIn _googleSignIn;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    void loginWithGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final String? accessToken = googleAuth?.accessToken;

        if (accessToken != null) {
          try {
            final res =
                await AuthService.loginWithGoogle(accessToken, authProvider);
            if (res != {} && res['isSuccess'] == true) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ListTutorsPage(),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(res['message'].toString()),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(res['message'].toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (error) {
            print(error);
          }
        }
      } catch (error) {
        //print(error);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/images/facebook-logo.svg',
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              loginWithGoogle();
            },
            child: SvgPicture.asset(
              'assets/images/google-logo.svg',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
