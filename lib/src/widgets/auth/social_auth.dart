import 'package:absurd_toolbox/src/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SocialLoginMode {
  google,
}

class SocialAuth extends StatelessWidget {
  const SocialAuth({Key? key}) : super(key: key);

  void socialSignIn(SocialLoginMode loginMode) async {
    switch (loginMode) {
      case SocialLoginMode.google:
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
                    "signInWithCredential error",
                    err,
                  );
                },
              ).whenComplete(() => EasyLoading.dismiss());
            }).catchError((err) {
              log(
                "googleUser?.authentication error",
                err,
              );
            });
          }).catchError((err) {
            log(
              "GoogleSignIn().signIn() error",
              err,
            );
          });
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignInButton(
              Buttons.Google,
              text: "Iniciar sesión con Google",
              onPressed: () => socialSignIn(SocialLoginMode.google),
            ),
          ],
        ),
      ),
    );
  }
}
