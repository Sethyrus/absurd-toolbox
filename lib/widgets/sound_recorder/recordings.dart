import 'dart:io';

import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/permissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Recordings extends StatefulWidget {
  @override
  _RecordingsState createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
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

    log(key: 'Recordings', value: _recordings);
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

  List<Widget>? _getErrors(Permissions permissions) {
    List<String> errors = [];

    if (permissions.permissions.storage != PermissionStatus.granted)
      errors.add('Debes conceder acceso al almacenamiento');

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

  @override
  Widget build(BuildContext context) {
    if (_playerInit) {
      return Consumer<Permissions>(
        builder: (context, permissions, child) {
          return Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: _getErrors(permissions) ??
                  List.generate(
                    _recordings.length,
                    (index) => Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: double.infinity,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _recordings[index].path.substring(
                                    _recordings[index].path.lastIndexOf('/') +
                                        1,
                                    _recordings[index].path.length),
                              ),
                              Icon(
                                currentPlayback == _recordings[index]
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              )
                            ],
                          ),
                        ),
                        onTap: () => _playRecording(_recordings[index]),
                      ),
                    ),
                  ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
