import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/app_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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

    return NeumorphicApp(
      builder: EasyLoading.init(),
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        // baseColor: Color(0xFF777777),
        accentColor: Color(0xFF777777),
        buttonStyle: NeumorphicStyle(
          color: Colors.white,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(128),
          ),
        ),
        // primarySwatch: createMaterialColor(const Color(0xFF777777)),
        // primaryColor: createMaterialColor(const Color(0xFF777777)),
        // primaryColorDark: createMaterialColor(const Color(0xFF444444)),
        // primarySwatch: Colors.indigo,
        // primaryColor: Colors.indigo,
        // primaryColorDark: Colors.indigo.shade800,
        // scaffoldBackgroundColor: Colors.white,
        // backgroundColor: Colors.white,
        // fontFamily: GoogleFonts.openSans.toString(),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const AppContainer(),
    );
  }
}
