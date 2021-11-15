import 'dart:io';
import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/models/permission_control.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recorder.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recordings.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/sound_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
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
  // Controla si se ha iniciado el servicio de grabación
  bool _recorderInit = false;
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  // Controla si el usuario ha concedido acceso al micrófono
  // PermissionStatus? _hasMicPermission;
  // Controla si el usuario ha concedido acceso al almacenamiento
  // PermissionStatus? _hasStoragePermission;
  // Códec usado en la grabación
  Codec _codec = Codec.aacMP4;
  // Controla si hay algún cçodec soportado
  bool _isCodecSupported = true;
  // Nombre del archivo temporal
  String _fileExtension = 'mp4';
  // Directorio temporal
  Directory? _tempDir;
  // Controla si se ha hecho alguna grabación
  // bool _isPlaybackReady = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      final Permissions permissions = Provider.of<Permissions>(
        context,
        listen: false,
      );

      PermissionStatus? hasMicPermission;
      PermissionStatus? hasStoragePermission;

      if (permissions.items.length > 0) {
        hasMicPermission = permissions.items
            .firstWhere(
              (p) => p.name == AppPermission.microphone,
            )
            .status;

        hasStoragePermission = permissions.items
            .firstWhere(
              (p) => p.name == AppPermission.storage,
            )
            .status;
      }

      if (hasMicPermission == null) {
        permissions.setPermission(
          PermissionControl(
            name: AppPermission.microphone,
            status: await Permission.microphone.request(),
          ),
        );
      }

      if (hasStoragePermission == null) {
        permissions.setPermission(
          PermissionControl(
            name: AppPermission.storage,
            status: await Permission.storage.request(),
          ),
        );
      }

      _player.openAudioSession().then(
            (value) => setState(
              () {
                _playerInit = true;
              },
            ),
          );

      _initRecorder().then(
        (value) => setState(
          () {
            _recorderInit = true;
            _isInit = true;
          },
        ),
      );
    });
  }

  _initRecorder() async {
    // _hasMicPermission = await Permission.microphone.request();
    // _hasStoragePermission = await Permission.storage.request();
    _tempDir = await getTemporaryDirectory();

    // if (_hasMicPermission == PermissionStatus.granted &&
    //     _hasStoragePermission == PermissionStatus.granted) {
    await _recorder.openAudioSession();

    if (!await _recorder.isEncoderSupported(_codec)) {
      _codec = Codec.opusWebM;
      _fileExtension = 'webm';

      if (!await _recorder.isEncoderSupported(_codec)) {
        _isCodecSupported = false;
        return;
      }
    }
    // }
    // await _recorder.openAudioSession();
  }

  // _initRecorder() async {
  //   // _hasMicPermission = await Permission.microphone.request();
  //   Permission.microphone.request().then((value) {
  //     _hasMicPermission = value;

  //     if (_hasMicPermission == PermissionStatus.granted) {
  //       _recorder.openAudioSession().then((value) {
  //         _recorder.isEncoderSupported(_codec).then(
  //           (value) {
  //             if (!value) {
  //               _codec = Codec.opusWebM;
  //               _filename = 'temp_recording.webm';
  //               _recorder.isEncoderSupported(_codec).then(
  //                 (value) {
  //                   if (!value) {
  //                     _isCodecSupported = false;
  //                   }

  //                   setState(() => _recorderInit = true);
  //                 },
  //               );
  //             } else {
  //               setState(() => _recorderInit = true);
  //             }
  //           },
  //         );
  //         // if (!await _recorder.isEncoderSupported(_codec)) {
  //         //   _codec = Codec.opusWebM;
  //         //   _filename = 'temp_recording.webm';

  //         //   if (!await _recorder.isEncoderSupported(_codec)) {
  //         //     _isCodecSupported = false;
  //         //     return;
  //         //   }
  //         // }
  //       });
  //     } else {
  //       setState(() => _recorderInit = true);
  //     }
  //   });

  //   // _hasStoragePermission = await Permission.storage.request();

  //   // _tempDir = await getTemporaryDirectory();

  //   // if (_hasMicPermission == PermissionStatus.granted &&
  //   //     _hasStoragePermission == PermissionStatus.granted) {
  //   //   await _recorder.openAudioSession();
  //   // }
  // }

  bool _isEverythingOk() =>
      _playerInit &&
      _recorderInit &&
      // _hasMicPermission == PermissionStatus.granted &&
      // _hasStoragePermission == PermissionStatus.granted &&
      _isCodecSupported &&
      _tempDir != null;

  List<String> _getErrors() {
    final List<String> _errors = [];

    if (!_isInit) return _errors;

    if (!_playerInit)
      _errors.add(
        'El servicio de reproducción no se ha iniciado\n',
      );

    if (!_recorderInit)
      _errors.add(
        'El servicio de grabación no se ha iniciado\n',
      );

    // if (_hasMicPermission == PermissionStatus.denied)
    //   _errors.add(
    //     'No has concedido acceso al micrófono\n',
    //   );

    // if (_hasMicPermission == PermissionStatus.permanentlyDenied)
    //   _errors.add(
    //     'Se ha denegado el acceso al micrófono permanentemente\n'
    //     'Puedes cambiar esto desde los ajustes del teléfono\n',
    //   );

    // if (_hasStoragePermission == PermissionStatus.denied)
    //   _errors.add(
    //     'No has concedido acceso al almacenamiento\n',
    //   );

    // if (_hasStoragePermission == PermissionStatus.permanentlyDenied)
    //   _errors.add(
    //     'Se ha denegado el acceso al almacenamiento permanentemente\n'
    //     'Puedes cambiar esto desde los ajustes del teléfono\n',
    //   );

    if (!_isCodecSupported)
      _errors.add(
        'Tu móvil no soporta ninguno de los códecs utilizados\n',
      );

    if (_tempDir != null)
      _errors.add(
        'No se tiene acceso a un directorio temporal\n',
      );

    return _errors;
  }

  @override
  Widget build(BuildContext context) {
    final Permissions permissions = Provider.of<Permissions>(
      context,
      listen: false,
    );

    return Consumer<Permissions>(builder: (context, cart, child) {
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
          content:
              // _isEverythingOk()
              //     ?
              TabBarView(
            children: [
              Recorder(
                player: _player,
                recorder: _recorder,
                codec: _codec,
                fileExtension: _fileExtension,
              ),
              Recordings(),
              SoundButtons(),
            ],
          )
          // : Column(
          //     children: _getErrors()
          //         .map((e) => Text(
          //               e,
          //               textAlign: TextAlign.center,
          //             ))
          //         .toList())
          ,
          // fab: _isEverythingOk()
          //     ? FloatingActionButton(
          //         onPressed: _getRecordingAction(),
          //         child: Icon(
          //           _isRecording ? Icons.pause : Icons.mic,
          //           color: Colors.black,
          //         ),
          //         backgroundColor: Colors.red.shade400,
          //       )
          //     : null,
        ),
      );
    });
  }
}
