import 'package:absurd_toolbox/screens/edit_profile_screen.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/profile/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade700,
      themeColor: Colors.indigo.shade400,
      themeStyle: ThemeStyle.Light,
      title: "Perfil",
      showAppBar: true,
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileDetails(),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(EditProfileScreen.routeName);
            //   },
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(
            //       Colors.indigo.shade400,
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.indigo.shade400,
                  ),
                ),
                child: Text("Cerrar sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
