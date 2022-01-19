import 'dart:io';
import 'package:absurd_toolbox/src/services/permissions_service.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/app_permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

    _initTempDir();

    _player!.openAudioSession().then(
          (value) => setState(() => _playerInit = true),
        );

    _initRecorder().then(
      (value) => setState(() => _recorderInit = true),
    );
  }

  @override
  void dispose() {
    // Se cierran los servicios de audio
    _player!.closeAudioSession();
    _player = null;
    _recorder!.closeAudioSession();
    _recorder = null;
    super.dispose();
  }

  void _initTempDir() {
    getTemporaryDirectory().then(
      (value) => setState(
        () {
          _tempDir = value;

          if (Directory(_tempDir?.path ?? '')
                  .listSync()
                  .toList()
                  .where(
                      (element) => element.path == _getTempRecordingFullPath())
                  .length >
              0) {
            _isPlaybackReady = true;
          }
        },
      ),
    );
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

  String _getTempRecordingFullPath() {
    return (_tempDir?.path ?? '') + '/temp_recording.' + _fileExtension;
  }

  void _startRecording() {
    log('Start recording');

    _recorder!
        .startRecorder(
          toFile: _getTempRecordingFullPath(),
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
    log('Stop recording');

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

  void _savePlayback() async {
    if (!_player!.isStopped) _stopPlayer();

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    if (!Directory(appDocumentsDirectory.path + '/recordings').existsSync())
      Directory(appDocumentsDirectory.path + '/recordings').createSync();

    String fileName =
        DateTime.now().millisecondsSinceEpoch.toString() + _fileExtension;

    try {
      File(_getTempRecordingFullPath())
          .renameSync(appDocumentsDirectory.path + '/recordings/' + fileName);
    } on FileSystemException catch (e) {
      log("Saving record method 2", e);

      File(_getTempRecordingFullPath())
          .copySync(appDocumentsDirectory.path + '/recordings/' + fileName);
      File(_getTempRecordingFullPath()).deleteSync();
    }

    setState(() {
      _isPlaybackReady = false;
    });
  }

  void _play() {
    _player!
        .startPlayer(
            fromURI: _getTempRecordingFullPath(),
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

  List<Widget>? _getErrors(AppPermissions permissions) {
    List<String> errors = [];

    // TODO comprobar si es necesario, en iOS parece funcionar el micrófono aún habiendo rechazado el permiso
    if (permissions.microphone != PermissionStatus.granted)
      errors.add('Debes conceder acceso al micrófono');

    if (!_isCodecSupported)
      errors.add('Tu teléfono no soporta ningún códec usado por la app');

    if (_tempDir?.path == null)
      errors.add('No se ha podido encontrar un directorio temporal');

    if (errors.length > 0) {
      return List<Widget>.generate(
        errors.length,
        (index) => Container(
          padding: EdgeInsets.only(
            bottom: 8,
          ),
          child: Text(
            errors[index],
          ),
        ),
      );
    } else {
      return null;
    }
  }

  bool _isInit() {
    return _playerInit && _recorderInit;
  }

  @override
  Widget build(BuildContext context) {
    if (_isInit()) {
      return StreamBuilder(
        stream: permissionsService.permissions,
        builder: (ctx, AsyncSnapshot<AppPermissions> permissions) {
          return Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: _getErrors(
                    permissions.hasData
                        ? (permissions.data ?? AppPermissions())
                        : AppPermissions(),
                  ) ??
                  [
                    Container(
                        child: Column(children: [
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
                                          _player!.isPlaying
                                              ? 'Parar'
                                              : 'Reproducir',
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _savePlayback,
                                        child: Text('Guardar grabación'),
                                      ),
                                    ]
                                  : [
                                      Text(
                                        'Pulsa sobre el botón para iniciar la grabación',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]
                            ]
                    ])),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
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
                  ],
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
