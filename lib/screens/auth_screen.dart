import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/auth/auth_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthMode {
  Login,
  Register,
}

enum SocialLoginMode {
  Google,
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
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void onSubmit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    final isFormValid = _form.currentState!.validate();

    if (isFormValid) {
      _form.currentState!.save();

      if (_authMode == AuthMode.Login) {
        emailSignIn();
      } else {
        register();
      }
    }
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
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    EasyLoading.dismiss();
  }

  void socialSignIn(SocialLoginMode loginMode) async {
    switch (loginMode) {
      case SocialLoginMode.Google:
        {
          GoogleSignIn().signIn().then((googleUser) {
            googleUser?.authentication.then((googleAuth) {
              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              FirebaseAuth.instance.signInWithCredential(credential).catchError(
                (err) {
                  print("signInWithCredential error");
                  print(err);
                },
              );
            }).catchError((err) {
              print("googleUser?.authentication error");
              print(err);
            });
          }).catchError((err) {
            print("GoogleSignIn().signIn() error");
            print(err);
          });
        }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
                                  autovalidateMode: autovalidateMode,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    print("VALIDATE EMAIL");
                                    print(value);
                                    if (value == null ||
                                        value.isEmpty ||
                                        !isEmailValid(value)) {
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
                                  autovalidateMode: autovalidateMode,
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
                                if (_authMode == AuthMode.Register)
                                  AuthInput(
                                    autovalidateMode: autovalidateMode,
                                    obscureText: true,
                                    validator: _authMode == AuthMode.Register
                                        ? (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return "Las contraseñas no coinciden";
                                            }
                                          }
                                        : null,
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
                        onPressed: () => socialSignIn(SocialLoginMode.Google),
                      ),
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
