import 'package:absurd_toolbox/src/screens/app_screens/auth_screen.dart';
import 'package:flutter/widgets.dart';

class AuthTitle extends StatelessWidget {
  final AuthMode authMode;

  const AuthTitle({Key? key, required this.authMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: 24, top: deviceSize.height * 0.075),
      child: Text(
        authMode == AuthMode.login ? 'Iniciar sesión' : 'Crear cuenta',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
