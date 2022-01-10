import 'package:absurd_toolbox/providers/user_profile.dart';
import 'package:absurd_toolbox/widgets/_general/space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfile>(
      builder: (context, userProfile, child) => Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black38,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(userProfile.userProfileData.avatar),
                      ),
                    ),
                  ),
                ],
              ),
              Space(size: 8),
              Text("Correo electrónico:"),
              Text(
                userProfile.userProfileData.email,
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
                userProfile.userProfileData.username,
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
                userProfile.userProfileData.description,
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
