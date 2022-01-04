import 'package:absurd_toolbox/providers/auth.dart';
import 'package:absurd_toolbox/screens/auth_screen.dart';
import 'package:absurd_toolbox/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Listener para los cambios en la autenticación que setea cada nuevo valor
    /// en su provider. Este puede ser un User válido, cuando se inicia sesión
    /// correctamente, o null cuando no existe o se ha cerrado la sesión
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        Provider.of<Auth>(context, listen: false).setAuth(user);
      },
    );

    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.openSans.toString(),
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: auth.isAuth ? TabsScreen() : AuthScreen(),
      ),
    );
  }
}
