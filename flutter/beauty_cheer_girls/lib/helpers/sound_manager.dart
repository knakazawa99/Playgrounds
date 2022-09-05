import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SoundManager {
  bool loop = false;

  SoundManager(this.loop);

  AudioPlayer audioPlayer = AudioPlayer();
  Future playLocal(String localFileName, double soundVolume,
      [bool assetFlg = true]) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$localFileName');
    if (!file.existsSync()) {
      final soundDataPath =
          assetFlg ? 'assets/sounds/$localFileName' : localFileName;
      final soundData = await rootBundle.load(soundDataPath);
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }
    if (loop == true) {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
    }
    await audioPlayer.play(DeviceFileSource(file.path), volume: soundVolume);
  }
}
