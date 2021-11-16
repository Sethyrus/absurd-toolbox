// import 'package:absurd_toolbox/models/permission_control.dart';
import 'package:absurd_toolbox/models/app_permissions.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recorder.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recordings.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/sound_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SoundRecorderScreen extends StatefulWidget {
  static const String routeName = '/sound-recorder';

  @override
  _SoundRecorderScreenState createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  // Controla si se ha iniciado todo lo necesario
  bool _isInit = false;
  // Controla si se ha iniciado el servicio de reproducción
  bool _playerInit = false;
  // // Controla si se ha iniciado el servicio de grabación
  // bool _recorderInit = false;
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  // // Códec usado en la grabación
  // Codec _codec = Codec.aacMP4;
  // // Controla si hay algún cçodec soportado
  // bool _isCodecSupported = true;
  // // Nombre del archivo temporal
  // String _fileExtension = 'mp4';

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      final Permissions permissions = Provider.of<Permissions>(
        context,
        listen: false,
      );

      PermissionStatus? hasMicPermission = permissions.permissions.microphone;
      PermissionStatus? hasStoragePermission = permissions.permissions.storage;

      if (hasMicPermission == null) {
        permissions.setPermission(
          PermissionName.microphone,
          await Permission.microphone.request(),
        );
      }

      if (hasStoragePermission == null) {
        permissions.setPermission(
          PermissionName.storage,
          await Permission.storage.request(),
        );
      }

      _player.openAudioSession().then(
            (value) => setState(
              () {
                _playerInit = true;
              },
            ),
          );

      // _initRecorder().then(
      //   (value) => setState(
      //     () {
      //       _recorderInit = true;
      //       _isInit = true;
      //     },
      //   ),
      // );
    });
  }

  // _initRecorder() async {
  //   await _recorder.openAudioSession();

  //   if (!await _recorder.isEncoderSupported(_codec)) {
  //     _codec = Codec.opusWebM;
  //     _fileExtension = 'webm';

  //     if (!await _recorder.isEncoderSupported(_codec)) {
  //       _isCodecSupported = false;
  //       return;
  //     }
  //   }
  // }

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
              Recorder(player: _player),
              Recordings(),
              SoundButtons(),
            ],
          )),
    );
  }
}
