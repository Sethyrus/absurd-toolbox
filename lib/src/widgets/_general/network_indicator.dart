import 'package:absurd_toolbox/src/services/connectivity_service.dart';
import 'package:flutter/material.dart';

class NetworkIndicator extends StatelessWidget {
  const NetworkIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: connectivityService.hasNetwork,
      builder: (ctx, AsyncSnapshot<bool> hasNetwork) {
        if (!hasNetwork.hasData || hasNetwork.data == true) {
          return const SizedBox.shrink();
        } else {
          return Positioned(
            top: MediaQuery.of(context).padding.top + 2,
            right: 2,
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                child: const Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                  size: 16,
                ),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(256),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
