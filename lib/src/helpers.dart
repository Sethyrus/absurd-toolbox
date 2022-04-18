import 'package:absurd_toolbox/src/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void log(String key, [Object? value, bool? debug = true]) {
  if (kDebugMode) {
    print(
      (debug == true ? '[DEBUG] ' : '') + key + (value != null ? ': ' : ''),
    );

    if (value != null) print(value);
  }
}

bool isEmailValid(String email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);

// TODO Añadir "modo", para cambiar el fondo en función de esto
void showToast(
  BuildContext context,
  String text, {
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: duration,
    ),
  );
}

ThemeData generateAppTheme(
  BuildContext context, {
  required Color primaryColor,
  required Color secondaryColor,
  SystemUiOverlayStyle? systemOverlayStyle,
}) {
  final double primaryLuminance = computeLuminance(primaryColor);

  systemOverlayStyle = systemOverlayStyle;

  if (systemOverlayStyle == null) {
    final double secondaryLuminance = computeLuminance(secondaryColor);

    systemOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: secondaryColor,
      statusBarIconBrightness: secondaryLuminance > luminanceThreshold
          ? Brightness.dark
          : Brightness.light,
      statusBarBrightness: secondaryLuminance > luminanceThreshold
          ? Brightness.light
          : Brightness.dark,
    );
  }

  Color appBarTextColor =
      primaryLuminance > luminanceThreshold ? Colors.black : Colors.white;

  return ThemeData(
    primarySwatch: createMaterialColor(primaryColor),
    primaryColor: Colors.indigo,
    primaryColorDark: Colors.indigo.shade800,
    appBarTheme: AppBarTheme(systemOverlayStyle: systemOverlayStyle),
    tabBarTheme: TabBarTheme(
      labelColor: appBarTextColor,
      unselectedLabelColor: appBarTextColor,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: appBarTextColor,
      ),
      unselectedLabelStyle: TextStyle(color: appBarTextColor),
    ),
    fontFamily: GoogleFonts.openSans.toString(),
    textTheme: GoogleFonts.openSansTextTheme(
      Theme.of(context).textTheme,
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

double computeLuminance(Color color) {
  return (0.2126 * color.red) + (0.7152 * color.green) + (0.0722 * color.blue);
}
