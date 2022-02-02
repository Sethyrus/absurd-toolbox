import 'package:absurd_toolbox/src/screens/app_screens/profile/edit_profile_screen.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/profile/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      secondaryColor: Theme.of(context).primaryColorDark,
      primaryColor: Theme.of(context).primaryColor,
      themeStyle: ThemeStyle.light,
      title: "Perfil",
      statusBarActions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(
            EditProfileScreen.routeName,
          ),
          icon: const Icon(Icons.edit),
        ),
      ],
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfileDetails(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                onPressed: FirebaseAuth.instance.signOut,
                child: const Text("Cerrar sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
