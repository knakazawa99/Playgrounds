import 'package:beauty_cheer_girls/components/girls_type_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:beauty_cheer_girls/helpers/sound_manager.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  void playBackgroundSounds() async {
    final SoundManager soundManager = SoundManager(true);
    await soundManager.playLocal('sofa.mp3', 0.1);
  }

  @override
  Widget build(BuildContext context) {

    playBackgroundSounds();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Cheer Girls',
      theme: _buildTheme(Brightness.light),
      home: const GirlsTypePage(),
    );
  }
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primarySwatch: Colors.blue,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
  );
}
