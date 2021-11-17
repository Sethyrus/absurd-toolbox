import 'dart:io';
import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  // Controla si se está realizando una grabación
  bool _isRecording = false;
  // Controla si hay alguna grabación previsualizable
  bool _isPlaybackReady = false;
  // Servicio de reproducción de audio
  FlutterSoundPlayer? _player = FlutterSoundPlayer();
  // Servicio de grabación de audio
  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  // Controla si se ha iniciado el servicio de reproducción
  bool _playerInit = false;
  // Controla si se ha iniciado el servicio de grabación
  bool _recorderInit = false;
  // Directorio temporal a usar para las grabaciones en proceso
  Directory? _tempDir;
  // Códec usado en la grabación
  Codec _codec = Codec.aacMP4;
  // Controla si hay algún codec soportado
  bool _isCodecSupported = true;
  // Nombre del archivo temporal
  String _fileExtension = 'mp4';

  @override
  void initState() {
    super.initState();

    // SchedulerBinding.instance!.addPostFrameCallback((_) async {
    getTemporaryDirectory().then((value) => setState(() => _tempDir = value));

    _player!.openAudioSession().then(
          (value) => setState(() => _playerInit = true),
        );

    _initRecorder().then(
      (value) => setState(() => _recorderInit = true),
    );
    // });
  }

  @override
  void dispose() {
    // Se cierran los servicios de audio
    _player!.closeAudioSession();
    _player = null;
    _recorder!.closeAudioSession();
    _player = null;
    super.dispose();
  }

  _initRecorder() async {
    await _recorder!.openAudioSession();

    if (!await _recorder!.isEncoderSupported(_codec)) {
      _codec = Codec.opusWebM;
      _fileExtension = 'webm';

      if (!await _recorder!.isEncoderSupported(_codec)) {
        _isCodecSupported = false;
        return;
      }
    }
  }

  String getTempRecordingDir() {
    return (_tempDir?.path ?? '') + '/temp_recording.' + _fileExtension;
  }

  void _startRecording() {
    log(key: 'Start recording');

    _recorder!
        .startRecorder(
          toFile: getTempRecordingDir(),
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

    await _recorder!.stopRecorder().then((value) {
      setState(() {
        _isRecording = false;
        _isPlaybackReady = true;
      });
    });
  }

  Function()? _getRecordingAction() =>
      _recorder!.isStopped ? _startRecording : _stopRecording;

  Function()? _getPlaybackAction() {
    if (!_isPlaybackReady || !_recorder!.isStopped) {
      return null;
    }

    return _player!.isStopped ? _play : _stopPlayer;
  }

  void _play() {
    _player!
        .startPlayer(
            fromURI: getTempRecordingDir(),
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void _stopPlayer() {
    _player!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  List<String> _getErrors(Permissions permissions) {
    List<String> errors = [];

    if (permissions.permissions.microphone != PermissionStatus.granted)
      errors.add('Debes conceder acceso al micrófono');

    if (permissions.permissions.storage != PermissionStatus.granted)
      errors.add('Debes conceder acceso al almacenamiento');

    if (!_isCodecSupported)
      errors.add('Tu teléfono no soporta ningún códec usado por la app');

    return errors;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Permissions>(
      builder: (context, permissions, child) {
        final List<String> errors = _getErrors(permissions);

        return Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: errors.length == 0
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: errors.length == 0
                ? [
                    Container(
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
                                            child: Text(_player!.isPlaying
                                                ? 'Stop'
                                                : 'Play'),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Container(
                        width: 64,
                        height: 64,
                        child: RawMaterialButton(
                          shape: new CircleBorder(),
                          fillColor: Colors.red.shade400,
                          child: Icon(
                            _isRecording ? Icons.pause : Icons.mic,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: _getRecordingAction(),
                        ),
                      ),
                    ),
                  ]
                : List<Widget>.generate(
                    errors.length,
                    (index) => Container(
                      padding: EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Text(
                        errors[index],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
