import 'package:absurd_toolbox/src/screens/app_screens/auth_screen.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  final AuthMode authMode;

  const ResetPassword({Key? key, required this.authMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          authMode == AuthMode.login
              ? '¿No tienes cuenta? '
              : "¿Ya tienes cuenta? ",
          style: TextStyle(color: Colors.grey.shade500),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (alertCtx) => AlertDialog(
                title: const Text('Error'),
                content: const Text(
                  'El registro con correo está desactivado temporalmente, utiliza la autenticación con Google',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(alertCtx),
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            );
          },
          child: Text(
            authMode == AuthMode.login ? 'Crea una' : "Iniciar sesión",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
