import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/profile/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade800,
      themeColor: Colors.indigo,
      themeStyle: ThemeStyle.light,
      title: "Perfil",
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfileDetails(),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(EditProfileScreen.routeName);
            //   },
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(
            //       Colors.indigo,
            //     ),
            //   ),
            //   child: Text("Editar perfil"),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                style: const ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all(
                    //   Colors.indigo,
                    // ),
                    ),
                child: const Text("Cerrar sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
