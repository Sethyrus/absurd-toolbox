import 'package:absurd_toolbox/src/screens/app_screens/auth_screen.dart';
import 'package:absurd_toolbox/src/screens/app_screens/tabs_screen.dart';
import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/network_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    connectivityService.initConnectivitySubscription();
    authService.initAuthSubscription();

    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    return MaterialApp(
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        primaryColorDark: Colors.indigo.shade800,
        fontFamily: GoogleFonts.openSans.toString(),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Stack(
        children: [
          StreamBuilder(
            stream: authService.isAuth,
            builder: (ctx, AsyncSnapshot<bool> isAuth) {
              /// Si hay una sesión iniciada se cargan los tabs; en caso
              /// contrario se muestra la página de autenticación
              if (isAuth.hasData && isAuth.data == true) {
                return const TabsScreen();
              } else {
                return const AuthScreen();
              }
            },
          ),
          const NetworkIndicator(),
        ],
      ),
    );
  }
}
