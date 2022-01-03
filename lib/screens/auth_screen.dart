import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/_general/space.dart';
import 'package:absurd_toolbox/widgets/auth/auth_form.dart';
import 'package:absurd_toolbox/widgets/auth/social_auth.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  Login,
  Register,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Layout(
      statusBarColor: Colors.white,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space(size: deviceSize.height * 0.075),
                AuthForm(authMode: _authMode),
                SocialAuth(),
                Container(
                  padding: EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.Login
                            ? '¿No tienes cuenta? '
                            : "¿Ya tienes cuenta? ",
                        style: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _authMode = _authMode == AuthMode.Login
                                  ? AuthMode.Register
                                  : AuthMode.Login;
                            },
                          );
                        },
                        child: Text(
                          _authMode == AuthMode.Login
                              ? 'Crea una'
                              : "Iniciar sesión",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
