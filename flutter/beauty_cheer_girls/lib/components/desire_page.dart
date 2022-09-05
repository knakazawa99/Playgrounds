import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:beauty_cheer_girls/components/girls_selection_page.dart';
import 'package:beauty_cheer_girls/models/spa_girl.dart';

import 'cheer_page.dart';

class DesirePage extends StatefulWidget {
  final int girlId;

  const DesirePage({
    Key? key,
    required this.girlId,
  }) : super(key: key);

  @override
  State<DesirePage> createState() => _DesirePageState();
}

class _DesirePageState extends State<DesirePage> {
  final List<SpaGirl> spaGirls = SpaGirls().create();

  @override
  void initState() {
    super.initState();
    Future(() async {
      await _getData();
    });
    spaGirls[widget.girlId].aitalk.playVoice(spaGirls[widget.girlId].dialogue);
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final selectedId = prefs.getInt('selectedGirlId');
    });
  }

  Future<void> _refreshSelectedGirlId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedGirlId');
  }

  @override
  Widget build(BuildContext context) {
    final spaGirl = spaGirls[widget.girlId];

    return Scaffold(
        backgroundColor: spaGirl.color,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Text(
                    spaGirl.dialogue,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 550,
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Comment(spaGirl: spaGirl, questionId: 0),
                          const SizedBox(height: 20),
                          _Comment(spaGirl: spaGirl, questionId: 1),
                          const SizedBox(height: 20),
                          _Comment(spaGirl: spaGirl, questionId: 2),
                          const SizedBox(height: 20),
                        ],
                      )),
                      SizedBox(
                          height: 400, child: Image.asset(spaGirl.imageSrc)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomSheet: Container(
            decoration: BoxDecoration(color: spaGirl.color),
            padding: const EdgeInsets.all(40),
            child: ElevatedButton.icon(
              onPressed: () {
                _refreshSelectedGirlId();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GirlsSelectionPage(),
                    ));
                spaGirls[widget.girlId]
                    .aitalk
                    .playVoice(spaGirls[widget.girlId].uwakiVoice);
              },
              label: const Text(
                '浮気',
                style: TextStyle(fontSize: 25),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black26)),
              icon:
                  const Icon(Icons.favorite, color: Colors.redAccent, size: 30),
            )));
  }
}

class _Comment extends StatelessWidget {
  final SpaGirl spaGirl;
  final int questionId;

  const _Comment({super.key, required this.spaGirl, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CheerPage(spaGirl: spaGirl, questionId: questionId),
            ));
      },
      child: Text(
        spaGirl.questions[questionId].word,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
