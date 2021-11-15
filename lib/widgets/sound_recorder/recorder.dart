import 'dart:io';

import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Recorder extends StatefulWidget {
  final FlutterSoundPlayer player;
  final FlutterSoundRecorder recorder;
  final Codec codec;
  final String fileExtension;

  Recorder({
    required this.player,
    required this.recorder,
    required this.codec,
    required this.fileExtension,
  });

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool _isRecording = false;
  bool _isPlaybackReady = false;
  Directory? _tempDir;

  void _startRecording() {
    log(key: 'Start recording');

    widget.recorder
        .startRecorder(
          toFile: (_tempDir?.path ?? '') +
              '/temp_recording.' +
              widget.fileExtension,
          codec: widget.codec,
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

    await widget.recorder.stopRecorder().then((value) {
      setState(() {
        _isRecording = false;
        _isPlaybackReady = true;
      });
    });
  }

  Function()? _getRecordingAction() =>
      widget.recorder.isStopped ? _startRecording : _stopRecording;

  Function()? _getPlaybackAction() {
    if (!_isPlaybackReady || !widget.recorder.isStopped) {
      return null;
    }

    return widget.player.isStopped ? _play : _stopPlayer;
  }

  void _play() {
    widget.player.startPlayer(
      fromURI:
          (_tempDir?.path ?? '') + '/temp_recording' + widget.fileExtension,
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
    widget.player.stopPlayer().then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    getTemporaryDirectory().then((value) => setState(() => _tempDir = value));

    // _tempDir = await getTemporaryDirectory();

    // if (_hasMicPermission == PermissionStatus.granted &&
    //     _hasStoragePermission == PermissionStatus.granted) {
    // await _recorder.openAudioSession();

    // // widget

    // if (!await _recorder.isEncoderSupported(_codec)) {
    //   _codec = Codec.opusWebM;
    //   _fileExtension = 'webm';

    //   if (!await _recorder.isEncoderSupported(_codec)) {
    //     _isCodecSupported = false;
    //     return;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Permissions>(
      builder: (context, cart, child) {
        return Container(
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
                                    widget.player.isPlaying ? 'Stop' : 'Play'),
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
        );
      },
    );
  }
}
