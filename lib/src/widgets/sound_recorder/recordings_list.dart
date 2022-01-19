import 'dart:io';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/widgets/sound_recorder/recordings_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class RecordingsList extends StatefulWidget {
  @override
  _RecordingsListState createState() => _RecordingsListState();
}

class _RecordingsListState extends State<RecordingsList> {
  // Servicio de reproducción de audio
  FlutterSoundPlayer? _player = FlutterSoundPlayer();
  // Controla si se ha iniciado el servicio de reproducción
  bool _playerInit = false;
  // Grabaciones guardadas
  List<FileSystemEntity> _recordings = [];
  FileSystemEntity? currentPlayback;

  @override
  void initState() {
    super.initState();

    _player!.openAudioSession().then(
          (value) => setState(() => _playerInit = true),
        );

    _loadFiles();
  }

  @override
  void dispose() {
    // Se cierran los servicios de audio
    _player!.closeAudioSession();
    _player = null;
    super.dispose();
  }

  void _loadFiles() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    if (!Directory(appDocumentsDirectory.path + '/recordings').existsSync())
      Directory(appDocumentsDirectory.path + '/recordings').createSync();

    _recordings = Directory(appDocumentsDirectory.path + '/recordings')
        .listSync()
        .toList();

    log('Recordings', _recordings);
  }

  void _playRecording(FileSystemEntity file) {
    if (_player!.isStopped || currentPlayback != file) {
      _player!
          .startPlayer(
              fromURI: file.path,
              whenFinished: () {
                setState(() {
                  currentPlayback = null;
                });
              })
          .then((value) {
        setState(() {
          currentPlayback = file;
        });
      });
    } else {
      _stopPlayer();
    }
  }

  void _stopPlayer() {
    _player!.stopPlayer().then((value) {
      setState(() {
        currentPlayback = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_playerInit) {
      return Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: List.generate(
            _recordings.length,
            (index) => RecordingsListItem(
              file: _recordings[index],
              isPlaying: currentPlayback == _recordings[index],
              onTap: _playRecording,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
