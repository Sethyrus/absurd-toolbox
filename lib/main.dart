import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:absurd_toolbox/src/widgets/_general/app_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'src/firebase_options.dart';

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

class _MyApp extends StatelessWidget {
  // Dummy focusNode al que hacer foco para quitarlo de otros
  final FocusNode _focusNode = FocusNode();

  _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Elimina el foco de cualquier input al pulsar sobre un espacio libre
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: const AppWrapper(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Se inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Se selecciona español como idioma por defecto de la aplicación
  Intl.defaultLocale = 'es_ES';
  // Se inicializan los textos para el formateo de fechas
  initializeDateFormatting('es_ES');
  // Se inicializa la configuración del loader
  loaderConfig();
  runApp(_MyApp());
}
