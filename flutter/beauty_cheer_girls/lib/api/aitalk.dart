import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/sound_manager.dart';

enum EmotionType { normal, sad, pleasure, anger }

class AITalkClient {
  final dio = Dio();
  final url = 'https://webapi.aitalk.jp/webapi/v5/ttsget.php'; // WEB API URL;
  final id = 'spajam2022';
  final pw = 'gGLgPWBp';
  final outputFile = 'output.mp3'; // mp3, ogg, m4a, wav いずれかのファイルパス

  String speakerName; // 話者名
  String inputType; // 合成文字種別
  String style; // 感情スタイル
  double volume; //音量（0.01-2.00）
  double speed; // 話速（0.50-4.00）
  double pitch; // ピッチ（0.50-2.00）
  double range; // 抑揚（0.00-2.00）
  double mvolume; // マスターボリューム（0.01-5.00）
  int spause; // 短ポーズ（80-500）
  int lpause; // 長ポーズ（100-2000）
  int epause; // 文末ポーズ（200-10000）
  int tpause; // 終端ポーズ（0-10000）
  final String outputType = 'sound'; // 出力形式
  final String ext = 'mp3'; // 出力音声形式
  final String useUdic = '1'; // ユーザー辞書利用フラグ

  // 感情パラメータ
  String normalStyle;
  String pleasureStyle;
  String angerStyle;
  String sadStyle;

  AITalkClient(
      {this.speakerName = 'nozomi_emo', // 話者名
      this.inputType = 'text', // 合成文字種別
      this.style = '{"j": "0.5"}', // 感情スタイル
      this.volume = 1.0, //音量（0.01-2.00）
      this.speed = 1.0, // 話速（0.50-4.00）
      this.pitch = 1.0, // ピッチ（0.50-2.00）
      this.range = 1.0, // 抑揚（0.00-2.00）
      this.mvolume = 1.0, // マスターボリューム（0.01-5.00）
      this.spause = 150, // 短ポーズ（80-500）
      this.lpause = 370, // 長ポーズ（100-2000）
      this.epause = 800, // 文末ポーズ（200-10000）
      this.tpause = 0, // 終端ポーズ（0-10000）

      // 感情パラメータ
      this.normalStyle = '{"j": "0.5"}',
      this.pleasureStyle = '{"j": "1.0"}',
      this.angerStyle = '{"s": "0.3","a": "0.7"}',
      this.sadStyle = '{"a": "1.0","s": "0.7"}'});

  Future<bool> transferRequest(String targetText) async {
    final username = id;
    final password = pw;

    // 合成結果データ
    // final _headers;
    // final _sound;
    // final _err_msg;

    final queryParams = {
      'username': username,
      'password': password,
      'speaker_name': speakerName,
      'style': style,
      'input_type': inputType,
      'text': targetText,
      'volume': volume,
      'speed': speed,
      'pitch': pitch,
      'range': range,
      'mvolume': mvolume,
      'spause': spause,
      'lpause': lpause,
      'epause': epause,
      'tpause': tpause,
      'output_type': outputType,
      'ext': ext,
      'use_udic': useUdic
    };

    final response = await dio.post(url,
        options: Options(responseType: ResponseType.bytes),
        queryParameters: queryParams);

    if (response.statusCode == 200) {
      try {
        final voice = response.data;

        // write file
        Directory appDocDirectory = await getApplicationDocumentsDirectory();
        final mp3FilePath = '${appDocDirectory.path}/${outputFile}';
        final file = File(mp3FilePath);
        file.writeAsBytes(voice);

        return true;
      } catch (e) {
        throw e;
      }
    }
    return false;
  }

  Future<void> playVoice(String targetText,
      [EmotionType emotionType = EmotionType.normal]) async {
    try {
      // change emotion
      switch (emotionType) {
        case EmotionType.sad:
          style = sadStyle;
          break;
        case EmotionType.anger:
          style = angerStyle;
          break;
        case EmotionType.normal:
          style = normalStyle;
          break;
        default:
          style = normalStyle;
          break;
      }

      await transferRequest(targetText);

      final mp3FilePath = outputFile;

      // play voice
      final SoundManager soundManager = SoundManager(false);
      await soundManager.playLocal(mp3FilePath, 1.0, false);
    } catch (error) {
      print(error);
    }
  }
}
