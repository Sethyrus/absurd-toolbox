import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/general_state.dart';
import 'package:absurd_toolbox/screens/auth_screen.dart';
import 'package:absurd_toolbox/screens/tabs_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Connectivity().checkConnectivity().then((result) {
      log(key: "First connectivity check", value: result);

      if (result != ConnectivityResult.none) {
        Provider.of<GeneralState>(context, listen: false)
            .setConnectivityStatus(result);
      }
    });

    Connectivity().onConnectivityChanged.listen((result) {
      log(key: "Connectivity change", value: result);
      Provider.of<GeneralState>(context, listen: false)
          .setConnectivityStatus(result);
    });

    return Consumer<GeneralState>(
      builder: (ctx, generalState, _) => Stack(
        children: [
          generalState.isAuth ? TabsScreen() : AuthScreen(),
          generalState.hasNetwork
              ? SizedBox.shrink()
              : Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 8,
                  child: Container(
                    child: Text(
                      "Tu dispositivo está desconectado de internet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 16,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
