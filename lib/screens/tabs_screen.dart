import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  Route _onGenerateRoute(RouteSettings settings, index) {
    final Widget page = appNavigator[index]
        .routes
        .firstWhere((route) => route.route == settings.name)
        .screen;

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  /// Al retroceder (usando la vía nativa del dispositivo, como swipe lateral o
  /// botón de retroceso) se lanza esta función. En esta primero se comprueba si
  /// en el tab activo ya se estaba en la página inicial: si no es así se retro-
  /// cede de forma normal, pero si ya se estaba se lanza una nueva comprobación
  /// de si el tab activo era distinto de 0 (primer tab, "home"), caso en que se
  /// navega a este tab 0. Si el tab activo era 0 se retrocede de forma normal,
  /// que por defecto debería cerrar la aplicación al no quedar elementos en el
  /// stack de navegación
  Future<bool> _onWillPop() async {
    late GlobalKey<NavigatorState> navigatorKey =
        appNavigator[_currentIndex].navigator;

    final hasPopped = await navigatorKey.currentState!.maybePop();

    if (!hasPopped && _currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return Future<bool>.value(false);
    } else {
      return Future<bool>.value(!hasPopped);
    }
  }

  /// Al pulsar sobre un tab, primero se comprueba si es el tab activo. Si lo
  /// es, se retrocede en el Navigator correspondiente hasta su página inicial;
  /// si no, se establece el tab seleccionado como tab activo
  void _onTabNavigation(int val, BuildContext context) {
    if (_currentIndex == val) {
      appNavigator[_currentIndex].navigator.currentState!.popUntil(
            (route) => route.isFirst,
          );
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context, listen: false);
    notesProvider.reloadNotes();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: List<Widget>.generate(
            appNavigator.length,
            (index) => Navigator(
              key: appNavigator[index].navigator,
              onGenerateRoute: (RouteSettings settings) => _onGenerateRoute(
                settings,
                index,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (val) => _onTabNavigation(val, context),
          selectedItemColor: Colors.indigo.shade400,
          items: List<BottomNavigationBarItem>.generate(
            appNavigator.length,
            (index) => BottomNavigationBarItem(
              icon: appNavigator[index].icon,
              label: appNavigator[index].label,
            ),
          ),
        ),
      ),
    );
  }
}
