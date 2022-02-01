import 'package:absurd_toolbox/src/screens/app%20screens/profile/edit_profile_screen.dart';
import 'package:absurd_toolbox/src/screens/app%20screens/profile/profile_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/chats_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/clock_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/flashlight_screen.dart';
import 'package:absurd_toolbox/src/screens/app%20screens/home_screen.dart';
import 'package:absurd_toolbox/src/screens/app%20screens/settings_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/notes/note_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/route.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/raffles_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox%20screens/sound_recorder_screen.dart';

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
    ],
    icon: const Icon(Icons.construction),
  ),
  AppNavigator(
    label: "Perfil",
    navigator: GlobalKey<NavigatorState>(),
    routes: [
      AppRoute(
        route: '/',
        screen: const ProfileScreen(),
      ),
      AppRoute(
        route: EditProfileScreen.routeName,
        screen: const EditProfileScreen(),
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
