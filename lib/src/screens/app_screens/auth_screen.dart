import 'package:absurd_toolbox/src/screens/app_screens/auth_title.dart';
import 'package:absurd_toolbox/src/screens/app_screens/reset_password.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/auth/auth_form.dart';
import 'package:absurd_toolbox/src/widgets/auth/social_auth.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  login,
  register,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthMode _authMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAppBar: false,
      secondaryColor: Colors.white,
      primaryColor: Theme.of(context).primaryColor,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTitle(authMode: _authMode),
                AuthForm(authMode: _authMode),
                const SocialAuth(),
                ResetPassword(authMode: _authMode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
