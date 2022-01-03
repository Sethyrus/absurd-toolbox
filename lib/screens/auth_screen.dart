import 'dart:math';

import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/auth.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/auth/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

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
  final _form = GlobalKey<FormState>();

  void onSubmit() {
    print("Submit");
    if (_authMode == AuthMode.Login) {
    } else {}
    // _form.currentState!.save();

    Provider.of<Auth>(context, listen: false).setAuth();
  }

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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: deviceSize.height * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _authMode == AuthMode.Login
                                ? 'Iniciar sesión'
                                : 'Crear cuenta',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AuthInput(
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
                                  prefixIcon: Icons.email,
                                  labelText: "E-mail",
                                ),
                                AuthInput(
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
                                  prefixIcon: Icons.lock,
                                  labelText: "Contraseña",
                                ),
                                if (_authMode == AuthMode.Register)
                                  AuthInput(
                                    obscureText: true,
                                    validator: _authMode == AuthMode.Register
                                        ? (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return "Las contraseñas no coinciden";
                                            }
                                          }
                                        : null,
                                    onSaved: (value) {
                                      _authData['email'] = value ?? '';
                                    },
                                    prefixIcon: Icons.lock,
                                    labelText: "Confirmar contraseña",
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: onSubmit,
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(128),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.indigo.shade400,
                                      ),
                                    ),
                                    child: Text(
                                      _authMode == AuthMode.Login
                                          ? 'Iniciar sesión'
                                          : 'Crear cuenta',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SignInButton(
                        Buttons.Google,
                        onPressed: () {},
                      ),
                      // SignInButton(
                      //   Buttons.Facebook,
                      //   onPressed: () {},
                      // ),
                      // SignInButton(
                      //   Buttons.GitHub,
                      //   onPressed: () {},
                      // ),
                      // SignInButton(
                      //   Buttons.Reddit,
                      //   onPressed: () {},
                      // ),
                      // SignInButton(
                      //   Buttons.Twitter,
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ),
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
