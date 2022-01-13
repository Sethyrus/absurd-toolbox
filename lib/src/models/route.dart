import 'package:flutter/material.dart';

class AppRoute {
  final Widget screen;
  final String route;

  AppRoute({
    required this.screen,
    required this.route,
  });
}

class AppNavigator {
  final String label;
  final GlobalKey<NavigatorState> navigator;
  final List<AppRoute> routes;
  final Icon icon;

  AppNavigator({
    required this.label,
    required this.navigator,
    required this.routes,
    required this.icon,
  });
}
