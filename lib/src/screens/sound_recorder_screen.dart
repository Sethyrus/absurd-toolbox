import 'package:absurd_toolbox/src/blocs/permissions_bloc.dart';
import 'package:absurd_toolbox/src/models/app_permissions.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/sound_recorder/recorder.dart';
import 'package:absurd_toolbox/src/widgets/sound_recorder/recordings_list.dart';
import 'package:absurd_toolbox/src/widgets/sound_recorder/sound_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:permission_handler/permission_handler.dart';

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
      if (permissionsBloc.permissionsSync.microphone == null ||
          permissionsBloc.permissionsSync.microphone ==
              PermissionStatus.denied) {
        permissionsBloc.setPermission(
          PermissionName.Microphone,
          await Permission.microphone.request(),
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
            RecordingsList(),
            SoundButtons(),
          ],
        ),
      ),
    );
  }
}
