import 'dart:io';
import 'package:flutter/material.dart';

class RecordingsListItem extends StatelessWidget {
  final FileSystemEntity file;
  final bool isPlaying;
  final void Function(FileSystemEntity) onTap;

  const RecordingsListItem({
    Key? key,
    required this.file,
    required this.isPlaying,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: const EdgeInsets.symmetric(
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
                file.path.substring(
                  file.path.lastIndexOf('/') + 1,
                  file.path.length,
                ),
              ),
              Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
              )
            ],
          ),
        ),
        onTap: () => onTap(file),
      ),
    );
  }
}
