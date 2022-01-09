import 'package:absurd_toolbox/providers/profile.dart';
import 'package:absurd_toolbox/widgets/_general/space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Profile>(
      builder: (context, profileData, child) => Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Correo electrónico:"),
              Text(
                profileData.profileData.email,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Space(size: 8),
              Text(
                "Nombre de usuario:",
              ),
              Text(
                profileData.profileData.username,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Space(size: 8),
              Text(
                "Descripción:",
              ),
              Text(
                profileData.profileData.description,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Space(size: 8),
            ],
          ),
        ),
      ),
    );
  }
}
