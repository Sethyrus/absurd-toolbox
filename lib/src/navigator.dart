import 'package:absurd_toolbox/src/screens/chats_screen.dart';
import 'package:absurd_toolbox/src/screens/clock_screen.dart';
import 'package:absurd_toolbox/src/screens/profile/edit_profile_screen.dart';
import 'package:absurd_toolbox/src/screens/flashlight_screen.dart';
import 'package:absurd_toolbox/src/screens/home_screen.dart';
import 'package:absurd_toolbox/src/screens/notes/note_screen.dart';
import 'package:absurd_toolbox/src/screens/profile/profile_screen.dart';
import 'package:absurd_toolbox/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/route.dart';
import 'package:absurd_toolbox/src/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/src/screens/notes/notes_screen.dart';
import 'package:absurd_toolbox/src/screens/raffles_screen.dart';
import 'package:absurd_toolbox/src/screens/sound_recorder_screen.dart';

final List<AppNavigator> appNavigator = [
  AppNavigator(
    label: "Toolbox",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: HomeScreen(),
      ),
      AppRoute(
        route: NotesScreen.routeName,
        screen: NotesScreen(),
      ),
      AppRoute(
        route: NoteScreen.routeName,
        screen: NoteScreen(),
      ),
      AppRoute(
        route: RafflesScreen.routeName,
        screen: RafflesScreen(),
      ),
      AppRoute(
        route: BarcodeScannerScreen.routeName,
        screen: BarcodeScannerScreen(),
      ),
      AppRoute(
        route: SoundRecorderScreen.routeName,
        screen: SoundRecorderScreen(),
      ),
      AppRoute(
        route: ChatsScreen.routeName,
        screen: ChatsScreen(),
      ),
      AppRoute(
        route: FlashlightScreen.routeName,
        screen: FlashlightScreen(),
      ),
      AppRoute(
        route: ClockScreen.routeName,
        screen: ClockScreen(),
      ),
    ],
    icon: Icon(Icons.construction),
  ),
  AppNavigator(
    label: "Perfil",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: ProfileScreen(),
      ),
      AppRoute(
        route: EditProfileScreen.routeName,
        screen: EditProfileScreen(),
      ),
    ],
    icon: Icon(Icons.person),
  ),
  AppNavigator(
    label: "Ajustes",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: SettingsScreen(),
      ),
    ],
    icon: Icon(Icons.settings),
  ),
];
