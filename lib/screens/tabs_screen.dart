import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/home_screen.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  final _homeNavigatorKey = GlobalKey<NavigatorState>();
  final _profileNavigatorKey = GlobalKey<NavigatorState>();
  final _settingsNavigatorKey = GlobalKey<NavigatorState>();

  Route _onGenerateHomeRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case '/':
        page = HomeScreen();
        break;
      case NotesScreen.routeName:
        page = NotesScreen();
        break;
      case NoteScreen.routeName:
        page = NoteScreen();
        break;
      case RafflesScreen.routeName:
        page = RafflesScreen();
        break;
      case BarcodeScannerScreen.routeName:
        page = BarcodeScannerScreen();
        break;
      case SoundRecorderScreen.routeName:
        page = SoundRecorderScreen();
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future<bool>.value(
        // TODO el maybePop debe lanzarse solo sobre el navigator activo
        !await _homeNavigatorKey.currentState!.maybePop(),
      ),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Navigator(
              key: _homeNavigatorKey,
              onGenerateRoute: _onGenerateHomeRoute,
            ),
            Navigator(
              key: _profileNavigatorKey,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("Cerrar sesión"),
                    ),
                  ),
                ),
              ),
            ),
            Navigator(
              key: _settingsNavigatorKey,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("Ajustes"),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (val) => _onTap(val, context),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Toolbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ajustes',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _homeNavigatorKey.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _profileNavigatorKey.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _settingsNavigatorKey.currentState!
              .popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
