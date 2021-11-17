import 'package:absurd_toolbox/models/app_permissions.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recorder.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recordings.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/sound_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SoundRecorderScreen extends StatefulWidget {
  static const String routeName = '/sound-recorder';

  @override
  _SoundRecorderScreenState createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      final Permissions permissions = Provider.of<Permissions>(
        context,
        listen: false,
      );

      if (permissions.permissions.microphone == null ||
          permissions.permissions.microphone == PermissionStatus.denied) {
        permissions.setPermission(
          PermissionName.microphone,
          await Permission.microphone.request(),
        );
      }

      if (permissions.permissions.storage == null ||
          permissions.permissions.storage == PermissionStatus.denied) {
        permissions.setPermission(
          PermissionName.storage,
          await Permission.storage.request(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Layout(
          statusBarColor: Colors.red,
          themeColor: Colors.red.shade400,
          title: 'Grabadora de sonidos',
          showAppBar: true,
          tabBarIndicatorColor: Colors.white,
          tabBarItems: [
            Tab(
              child: Text(
                'Grabar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Grabaciones',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                'Sound buttons',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          content: TabBarView(
            children: [
              Recorder(),
              Recordings(),
              SoundButtons(),
            ],
          )),
    );
  }
}
