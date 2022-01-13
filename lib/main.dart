import 'package:absurd_toolbox/providers/general_state.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:absurd_toolbox/providers/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void loaderConfig() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  loaderConfig();
}

class MyApp extends StatelessWidget {
  // Dummy focusNode al que hacer foco para quitarlo de otros
  final FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Permissions>(create: (_) => Permissions()),
        ChangeNotifierProvider<GeneralState>(create: (_) => GeneralState()),
        ChangeNotifierProxyProvider<GeneralState, Notes>(
          create: (BuildContext context) => Notes(Provider.of<GeneralState>(
            context,
            listen: false,
          )),
          update: (context, generalState, notes) => Notes(generalState),
        ),
        ChangeNotifierProxyProvider<GeneralState, UserProfile>(
          create: (BuildContext context) =>
              UserProfile(Provider.of<GeneralState>(
            context,
            listen: false,
          )),
          update: (context, generalState, notes) => UserProfile(generalState),
        ),
      ],
      child: GestureDetector(
        // Elimina el foco de cualquier input al pulsar sobre un espacio libre
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: MyMaterialApp(),
      ),
    );
  }
}
