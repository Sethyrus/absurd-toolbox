import 'dart:io';
import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/recordings.dart';
import 'package:absurd_toolbox/widgets/sound_recorder/sound_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  PermissionStatus? _hasMicPermission;
  // Controla si el usuario ha concedido acceso al almacenamiento
  PermissionStatus? _hasStoragePermission;
  // Códec usado en la grabación
  Codec _codec = Codec.aacMP4;
  // Controla si hay algún cçodec soportado
  bool _isCodecSupported = true;
  // Nombre del archivo temporal
  String _filename = 'temp_recording.mp4';
  // Directorio temporal
  Directory? _tempDir;
  // Controla si se ha hecho alguna grabación
  bool _isPlaybackReady = false;
  bool _isRecording = false;

  @override
  void initState() {
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

    super.initState();
  }

  _initRecorder() async {
    _hasMicPermission = await Permission.microphone.request();
    _hasStoragePermission = await Permission.storage.request();
    _tempDir = await getTemporaryDirectory();

    if (_hasMicPermission == PermissionStatus.granted &&
        _hasStoragePermission == PermissionStatus.granted) {
      await _recorder.openAudioSession();

      if (!await _recorder.isEncoderSupported(_codec)) {
        _codec = Codec.opusWebM;
        _filename = 'temp_recording.webm';

        if (!await _recorder.isEncoderSupported(_codec)) {
          _isCodecSupported = false;
          return;
        }
      }
    }
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

  void _startRecording() {
    log(key: 'Start recording');

    _recorder
        .startRecorder(
          toFile: (_tempDir?.path ?? '') + '/' + _filename,
          codec: _codec,
        )
        .then(
          (value) => setState(
            () {
              _isRecording = true;
            },
          ),
        );
  }

  void _stopRecording() async {
    log(key: 'Stop recording');

    await _recorder.stopRecorder().then((value) {
      setState(() {
        _isRecording = false;
        _isPlaybackReady = true;
      });
    });
  }

  Function()? _getRecordingAction() =>
      _recorder.isStopped ? _startRecording : _stopRecording;

  Function()? _getPlaybackAction() {
    if (!_isPlaybackReady || !_recorder.isStopped) {
      return null;
    }

    return _player.isStopped ? _play : _stopPlayer;
  }

  void _play() {
    _player.startPlayer(
      fromURI: (_tempDir?.path ?? '') + '/' + _filename,
      // whenFinished: () {
      //   setState(() {});
      // }
    )
        //     .then((value) {
        //   setState(() {});
        // })
        ;
  }

  void _stopPlayer() {
    _player.stopPlayer().then((value) {
      setState(() {});
    });
  }

  bool _isEverythingOk() =>
      _playerInit &&
      _recorderInit &&
      _hasMicPermission == PermissionStatus.granted &&
      _hasStoragePermission == PermissionStatus.granted &&
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

    if (_hasMicPermission == PermissionStatus.denied)
      _errors.add(
        'No has concedido acceso al micrófono\n',
      );

    if (_hasMicPermission == PermissionStatus.permanentlyDenied)
      _errors.add(
        'Se ha denegado el acceso al micrófono permanentemente\n'
        'Puedes cambiar esto desde los ajustes del teléfono\n',
      );

    if (_hasStoragePermission == PermissionStatus.denied)
      _errors.add(
        'No has concedido acceso al almacenamiento\n',
      );

    if (_hasStoragePermission == PermissionStatus.permanentlyDenied)
      _errors.add(
        'Se ha denegado el acceso al almacenamiento permanentemente\n'
        'Puedes cambiar esto desde los ajustes del teléfono\n',
      );

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
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                children: [
                  ..._isRecording
                      ? [
                          Text(
                            'Grabando...',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 24,
                            ),
                          )
                        ]
                      : [
                          ..._isPlaybackReady
                              ? [
                                  ElevatedButton(
                                    onPressed: _getPlaybackAction(),
                                    child: Text(
                                        _player.isPlaying ? 'Stop' : 'Play'),
                                  ),
                                ]
                              : [
                                  Text(
                                    'Pulsa sobre el botón para iniciar una grabación',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ]
                        ],
                ],
              ),
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
  }
}
