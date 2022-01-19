import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:absurd_toolbox/src/screens/auth_screen.dart';
import 'package:absurd_toolbox/src/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: authService.isAuth,
          builder: (ctx, AsyncSnapshot<bool> isAuth) {
            return isAuth.hasData && isAuth.data == true
                ? TabsScreen()
                : AuthScreen();
          },
        ),
        StreamBuilder(
          stream: connectivityService.hasNetwork,
          builder: (ctx, AsyncSnapshot<bool> hasNetwork) {
            return !hasNetwork.hasData || hasNetwork.data == true
                ? SizedBox.shrink()
                : Positioned(
                    top: MediaQuery.of(context).padding.top + 2,
                    right: 2,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        child: Icon(
                          Icons.wifi_off,
                          color: Colors.white,
                          size: 16,
                        ),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(256),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
