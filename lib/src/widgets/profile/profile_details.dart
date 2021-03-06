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
        SizedBox(
          width: double.infinity,
          child: StreamBuilder(
            stream: userProfileService.userProfile,
            builder: (ctx, AsyncSnapshot<UserProfile> userProfile) {
              return Column(
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
                  const Space(size: 8),
                  const Text("Correo electr??nico:"),
                  Text(
                    userProfile.data?.email ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Space(size: 8),
                  const Text(
                    "Nombre de usuario:",
                  ),
                  Text(
                    userProfile.data?.username ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Space(size: 8),
                  const Text(
                    "Descripci??n del perfil:",
                  ),
                  Text(
                    userProfile.data?.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Space(size: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
