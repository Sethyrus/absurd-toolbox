import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/_general/space.dart';
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
  AuthMode _authMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Layout(
      showAppBar: false,
      secondaryColor: Colors.white,
      primaryColor: Theme.of(context).primaryColor,
      themeStyle: ThemeStyle.light,
      content: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space(size: deviceSize.height * 0.075),
                AuthForm(authMode: _authMode),
                const SocialAuth(),
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.login
                            ? '¿No tienes cuenta? '
                            : "¿Ya tienes cuenta? ",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _authMode = _authMode == AuthMode.login
                                  ? AuthMode.register
                                  : AuthMode.login;
                            },
                          );
                        },
                        child: Text(
                          _authMode == AuthMode.login
                              ? 'Crea una'
                              : "Iniciar sesión",
                          style: const TextStyle(
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
