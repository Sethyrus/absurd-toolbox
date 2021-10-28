import 'dart:io';
import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
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

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.red,
      themeColor: Colors.red.shade400,
      title: 'Grabadora de sonidos',
      showAppBar: true,
      content: _isEverythingOk()
          ? Container(
              child: Column(
                children: [
                  Text(
                    _isRecording.toString(),
                  ),
                  Text(
                    _recorder.isStopped.toString(),
                  ),
                  ElevatedButton(
                    onPressed: _getPlaybackAction(),
                    child: Text(_player.isPlaying ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Text('Errores:'),
                ..._playerInit
                    ? []
                    : [Text('El servicio de reproducción no se ha iniciado')],
                ..._recorderInit
                    ? []
                    : [Text('El servicio de grabación no se ha iniciado')],
                ..._hasMicPermission == PermissionStatus.granted
                    ? []
                    : [Text('No has concedido acceso al micrófono')],
                ..._hasStoragePermission == PermissionStatus.granted
                    ? []
                    : [Text('No has concedido acceso al almacenamiento')],
                ..._isCodecSupported
                    ? []
                    : [Text('Tu móvil no soporta ningún códec de estos')],
                ..._tempDir != null
                    ? []
                    : [Text('No se tiene acceso a un directorio temporal')],
              ],
            ),
      fab: _isEverythingOk()
          ? FloatingActionButton(
              onPressed: _getRecordingAction(),
              child: Icon(
                _isRecording ? Icons.pause : Icons.mic,
                color: Colors.black,
              ),
              backgroundColor: Colors.red.shade400,
            )
          : null,
    );
  }
}
