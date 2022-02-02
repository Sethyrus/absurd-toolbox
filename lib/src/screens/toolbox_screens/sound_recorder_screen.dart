import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/services/permissions_service.dart';
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

  const SoundRecorderScreen({Key? key}) : super(key: key);

  @override
  _SoundRecorderScreenState createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      if (permissionsService.permissionsSync.microphone == null ||
          permissionsService.permissionsSync.microphone ==
              PermissionStatus.denied) {
        permissionsService.setPermission(
          PermissionName.microphone,
          await Permission.microphone.request(),
        );
      }

      showDialog(
        context: context,
        builder: (alertCtx) => AlertDialog(
          title: const Text('Atención'),
          content: const Text(
            'Esta función está en desarrollo y es inestable, no se recomienda su uso',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(alertCtx),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere(
      (t) => t.route == SoundRecorderScreen.routeName,
    );

    return DefaultTabController(
      length: 3,
      child: Layout(
        secondaryColor: tool.secondaryColor,
        primaryColor: tool.primaryColor,
        textThemeStyle: tool.textThemeStyle,
        title: tool.name,
        tabBarIndicatorColor: Colors.white,
        tabBarItems: const [
          Tab(
            child: Text('Grabar'),
          ),
          Tab(
            child: Text('Grabaciones'),
          ),
          Tab(
            child: Text('Sound buttons'),
          ),
        ],
        content: const TabBarView(
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
