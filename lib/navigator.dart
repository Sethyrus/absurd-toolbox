import 'package:absurd_toolbox/screens/chats_screen.dart';
import 'package:absurd_toolbox/screens/edit_profile_screen.dart';
import 'package:absurd_toolbox/screens/home_screen.dart';
import 'package:absurd_toolbox/screens/maps_screen.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/screens/profile_screen.dart';
import 'package:absurd_toolbox/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/route.dart';
import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';

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
        route: MapsScreen.routeName,
        screen: MapsScreen(),
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
