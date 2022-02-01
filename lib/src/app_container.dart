import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:absurd_toolbox/src/screens/auth_screen.dart';
import 'package:absurd_toolbox/src/screens/tabs_screen.dart';
import 'package:absurd_toolbox/src/widgets/_general/network_indicator.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: authService.isAuth,
          builder: (ctx, AsyncSnapshot<bool> isAuth) {
            /// Si hay una sesión iniciada se cargan los tabs; en caso contra-
            /// rio, se muestra la página de autenticación
            if (isAuth.hasData && isAuth.data == true) {
              return const TabsScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
        const NetworkIndicator(),
      ],
    );
  }
}
