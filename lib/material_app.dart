import 'package:absurd_toolbox/app_wrapper.dart';
import 'package:absurd_toolbox/providers/auth.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/providers/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Listener para los cambios en la autenticación que setea cada nuevo valor
    /// en su provider. Este puede ser un User válido, cuando se inicia sesión
    /// correctamente, o null cuando no existe o se ha cerrado la sesión
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        Provider.of<Auth>(context, listen: false).setAuth(user);

        // Si no hay sesión se cancelan los listeners
        if (user == null) {
          Provider.of<Notes>(
            context,
            listen: false,
          ).cancelSubscriptions();

          Provider.of<UserProfile>(
            context,
            listen: false,
          ).cancelSubscriptions();
        }
      },
    );

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
      home: AppWrapper(),
    );
  }
}
