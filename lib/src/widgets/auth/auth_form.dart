import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/screens/auth_screen.dart';
import 'package:absurd_toolbox/src/widgets/_general/space.dart';
import 'package:absurd_toolbox/src/widgets/auth/auth_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthForm extends StatefulWidget {
  final AuthMode authMode;

  AuthForm({
    required this.authMode,
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _form = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  Map<String, String> _authData = {
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
        log(
            key: "FirebaseAuthException",
            value: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log(
            key: "FirebaseAuthException",
            value: 'The account already exists for that email.');
      }
    } catch (e) {
      log(key: "FirebaseAuthException uncontrolled", value: e);
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
        log(
            key: "FirebaseAuthException",
            value: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log(
            key: "FirebaseAuthException",
            value: 'Wrong password provided for that user.');
      }
    }

    EasyLoading.dismiss();
  }

  void onSubmit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final isFormValid = _form.currentState!.validate();

    if (isFormValid) {
      _form.currentState!.save();

      if (widget.authMode == AuthMode.Login) {
        emailSignIn();
      } else {
        register();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.authMode == AuthMode.Login
                    ? 'Iniciar sesión'
                    : 'Crear cuenta',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Space(size: 16),
              Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthInput(
                      autovalidateMode: _autovalidateMode,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El email no puede estar vacío";
                        } else if (!isEmailValid(value)) {
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
                      autovalidateMode: _autovalidateMode,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "La contraseña debe tener al menos 6 caracteres";
                        }
                      },
                      controller: _passwordController,
                      onSaved: (value) {
                        _authData['password'] = value ?? '';
                      },
                      prefixIcon: Icons.lock,
                      labelText: "Contraseña",
                    ),
                    if (widget.authMode == AuthMode.Register)
                      AuthInput(
                        autovalidateMode: _autovalidateMode,
                        obscureText: true,
                        validator: widget.authMode == AuthMode.Register
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return "Las contraseñas no coinciden";
                                }
                              }
                            : null,
                        prefixIcon: Icons.lock,
                        labelText: "Confirmar contraseña",
                      ),
                    Space(size: 16),
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
                          backgroundColor: MaterialStateProperty.all(
                            Colors.indigo.shade400,
                          ),
                        ),
                        child: Text(
                          widget.authMode == AuthMode.Login
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
    );
  }
}