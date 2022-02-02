import 'package:absurd_toolbox/src/screens/app_screens/account/edit_account_screen.dart';
import 'package:absurd_toolbox/src/screens/app_screens/account/account_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/chats_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/clock_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/flashlight_screen.dart';
import 'package:absurd_toolbox/src/screens/app_screens/home_screen.dart';
import 'package:absurd_toolbox/src/screens/app_screens/settings_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/notes/note_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/notes/notes_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/unit_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/route.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/raffles_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/sound_recorder_screen.dart';

final List<AppNavigator> appNavigator = [
  AppNavigator(
    label: "Toolbox",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: const HomeScreen(),
      ),
      AppRoute(
        route: NotesScreen.routeName,
        screen: const NotesScreen(),
      ),
      AppRoute(
        route: NoteScreen.routeName,
        screen: const NoteScreen(),
      ),
      AppRoute(
        route: RafflesScreen.routeName,
        screen: const RafflesScreen(),
      ),
      AppRoute(
        route: BarcodeScannerScreen.routeName,
        screen: const BarcodeScannerScreen(),
      ),
      AppRoute(
        route: SoundRecorderScreen.routeName,
        screen: const SoundRecorderScreen(),
      ),
      AppRoute(
        route: ChatsScreen.routeName,
        screen: const ChatsScreen(),
      ),
      AppRoute(
        route: FlashlightScreen.routeName,
        screen: const FlashlightScreen(),
      ),
      AppRoute(
        route: ClockScreen.routeName,
        screen: const ClockScreen(),
      ),
      AppRoute(
        route: UnitConverterScreen.routeName,
        screen: const UnitConverterScreen(),
      ),
    ],
    icon: const Icon(Icons.construction),
  ),
  AppNavigator(
    label: "Cuenta",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: const AccountScreen(),
      ),
      AppRoute(
        route: EditAccountScreen.routeName,
        screen: const EditAccountScreen(),
      ),
    ],
    icon: const Icon(Icons.person),
  ),
  AppNavigator(
    label: "Ajustes",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: const SettingsScreen(),
      ),
    ],
    icon: const Icon(Icons.settings),
  ),
];
