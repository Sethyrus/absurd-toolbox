import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
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
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Layout(
      statusBarColor: Colors.indigo.shade800,
      content: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.shade700,
              Colors.indigo.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 96,
              color: Colors.yellow[600],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Container(
                width: deviceSize.width * 0.75,
                padding: EdgeInsets.all(12),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: "E-mail"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty && !isEmailValid(value)) {
                              return "El e-mail no tiene un formato válido";
                            }
                          },
                          onSaved: (value) {
                            _authData['email'] = value ?? '';
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Contraseña"),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }
                          },
                          controller: _passwordController,
                          onSaved: (value) {
                            _authData['email'] = value ?? '';
                          },
                        ),
                        if (_authMode == AuthMode.Register)
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Validar contraseña"),
                            obscureText: true,
                            validator: _authMode == AuthMode.Register
                                ? (value) {
                                    if (value != _passwordController.text) {
                                      return "Las contraseñas no coinciden";
                                    }
                                  }
                                : null,
                            onSaved: (value) {
                              _authData['email'] = value ?? '';
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
