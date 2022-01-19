import 'package:absurd_toolbox/src/app_container.dart';
import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class MyMaterialApp extends StatelessWidget {
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
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.openSans.toString(),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AppContainer(),
    );
  }
}
