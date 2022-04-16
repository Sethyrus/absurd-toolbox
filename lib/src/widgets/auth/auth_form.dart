import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/screens/app_screens/auth_screen.dart';
import 'package:absurd_toolbox/src/widgets/_general/space.dart';
import 'package:absurd_toolbox/src/widgets/_general/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthForm extends StatefulWidget {
  final AuthMode authMode;

  const AuthForm({
    Key? key,
    required this.authMode,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  // TODO mostrar toast en caso de errores
  void register() async {
    EasyLoading.show();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _authData['email'] ?? '',
        password: _authData['password'] ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log("FirebaseAuthException", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log("FirebaseAuthException",
            'The account already exists for that email.');
      }
    } catch (e) {
      log("FirebaseAuthException uncontrolled", e);
    }

    EasyLoading.dismiss();
  }

  // TODO mostrar toast en caso de errores
  void emailSignIn() async {
    EasyLoading.show();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _authData['email'] ?? '',
        password: _authData['password'] ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log("FirebaseAuthException", 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log("FirebaseAuthException", 'Wrong password provided for that user.');
      }
    }

    EasyLoading.dismiss();
  }

  void onSubmit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      if (widget.authMode == AuthMode.login) {
        emailSignIn();
      } else {
        register();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Input(
                        autovalidateMode: _autovalidateMode,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El email no puede estar vacío";
                          } else if (!isEmailValid(value)) {
                            return "El e-mail no tiene un formato válido";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value ?? '';
                        },
                        prefixIcon: Icons.email,
                        labelText: "E-mail",
                      ),
                      Input(
                        autovalidateMode: _autovalidateMode,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "La contraseña debe tener al menos 6 caracteres";
                          }

                          return null;
                        },
                        controller: _passwordController,
                        onSaved: (value) {
                          _authData['password'] = value ?? '';
                        },
                        prefixIcon: Icons.lock,
                        labelText: "Contraseña",
                      ),
                      if (widget.authMode == AuthMode.register)
                        Input(
                          autovalidateMode: _autovalidateMode,
                          obscureText: true,
                          validator: widget.authMode == AuthMode.register
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return "Las contraseñas no coinciden";
                                  }

                                  return null;
                                }
                              : null,
                          prefixIcon: Icons.lock,
                          labelText: "Confirmar contraseña",
                        ),
                      const Space(size: 16),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: onSubmit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(128),
                              ),
                            ),
                          ),
                          child: Text(
                            widget.authMode == AuthMode.login
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
    );
  }
}
