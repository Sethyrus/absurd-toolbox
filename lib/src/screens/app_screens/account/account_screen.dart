import 'package:absurd_toolbox/src/screens/app_screens/account/edit_account_screen.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/profile/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      secondaryColor: Theme.of(context).primaryColorDark,
      primaryColor: Theme.of(context).primaryColor,
      textThemeStyle: TextThemeStyle.light,
      title: "Cuenta",
      statusBarActions: [
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(
            EditAccountScreen.routeName,
          ),
          icon: const Icon(Icons.edit),
        ),
      ],
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ProfileDetails(),
            ElevatedButton(
              onPressed: FirebaseAuth.instance.signOut,
              child: const Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
