import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:absurd_toolbox/src/services/user_profile_service.dart';
import 'package:absurd_toolbox/src/models/user_profile.dart';
import 'package:absurd_toolbox/src/widgets/_general/space.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: userProfileService.userProfile,
          builder: (ctx, AsyncSnapshot<UserProfile> userProfile) {
            return Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: connectivityService.hasNetwork,
                            builder: (ctx, AsyncSnapshot<bool> hasNetwork) {
                              return Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                  image: hasNetwork.hasData &&
                                          hasNetwork.data == true
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              userProfile.data?.avatar ?? ''),
                                        )
                                      : null,
                                ),
                              );
                            }),
                      ],
                    ),
                    Space(size: 8),
                    Text("Correo electrónico:"),
                    Text(
                      userProfile.data?.email ?? '',
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
                      userProfile.data?.username ?? '',
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
                      userProfile.data?.description ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(size: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
