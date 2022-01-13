import 'package:absurd_toolbox/src/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SocialLoginMode {
  Google,
}

class SocialAuth extends StatelessWidget {
  void socialSignIn(SocialLoginMode loginMode) async {
    switch (loginMode) {
      case SocialLoginMode.Google:
        {
          GoogleSignIn().signIn().then((googleUser) {
            googleUser?.authentication.then((googleAuth) {
              EasyLoading.show();

              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              FirebaseAuth.instance.signInWithCredential(credential).catchError(
                (err) {
                  log(
                    key: "signInWithCredential error",
                    value: err,
                  );
                },
              ).whenComplete(() => EasyLoading.dismiss());
            }).catchError((err) {
              log(
                key: "googleUser?.authentication error",
                value: err,
              );
            });
          }).catchError((err) {
            log(
              key: "GoogleSignIn().signIn() error",
              value: err,
            );
          });
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            text: "Iniciar sesión con Google",
            onPressed: () => socialSignIn(SocialLoginMode.Google),
          ),
        ],
      ),
    );
  }
}
