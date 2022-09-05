import 'package:beauty_cheer_girls/models/spa_girl.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import 'girls_selection_page.dart';

class CheerPage extends StatefulWidget {
  final SpaGirl spaGirl;
  final int questionId;

  const CheerPage({super.key, required this.spaGirl, required this.questionId});

  @override
  State<CheerPage> createState() => _CheerPageState();
}

class _CheerPageState extends State<CheerPage> {
  late final SpaGirl spaGirl;
  late final Future<Answer> answer;

  final List<Map<String, String>> cheerBotProperNouns = [
    {'東郷さん': 'あなた'},
    {'勇者部の活動': '活動'},
    {'赤嶺ちゃん': 'あなた'},
    {'須美ちゃん': 'あなた'},
    {'若葉ちゃん': 'あなた'},
    {'お姉ちゃん': 'あなた'},
    {'タマちゃん': 'あなた'},
    {'高嶋ちゃん': 'あなた'},
    {'夏凛ちゃん': 'あなた'},
    {'風先輩': 'あなた'},
    {'バーテックス': '犬'},
    {'だって': ''},
    {'だって、': ''},
    {'だから': ''},
    {'だから、': ''},
    {'じゃなくて、': ''},
  ];

  Future<Answer> getAnswer() async {
    if (spaGirl.questions[widget.questionId].answer == null) {
      return createAnswer(
          spaGirl.questions[widget.questionId].word, spaGirl.characterTextName);
    } else {
      return Future(() => Answer(response: spaGirl.questions[widget.questionId].answer ?? ''));
    }

  }

  @override
  void initState() {
    super.initState();
    spaGirl = widget.spaGirl;
    answer = getAnswer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: spaGirl.color,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 120),
                Container(
                  height: 550,
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FutureBuilder<Answer>(
                            future: answer,
                            builder: (context, snapshot) {
                              String generatedText = snapshot.data?.response ?? '';
                              for (var i=0; i<cheerBotProperNouns.length; i++) {
                                generatedText = generatedText.replaceAll(cheerBotProperNouns[i].keys.toList()[0], cheerBotProperNouns[i].values.toList()[0]);
                              }
                              if (snapshot.hasData) {
                                // NOTE character talk the line
                                spaGirl.aitalk.playVoice(
                                    generatedText,
                                    spaGirl.questions[widget.questionId]
                                        .answerType);
                                return Bubble(
                                  margin: const BubbleEdges.only(top: 10),
                                  nip: BubbleNip.rightBottom,
                                  color: Colors.white54,
                                  child: Text(
                                    generatedText,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 20),
                                  ),
                                );
                              }
                              // TODO ここ変えればテキストとってくるときのローディング変わる
                              return Bubble(
                                margin: const BubbleEdges.only(top: 10),
                                nip: BubbleNip.rightBottom,
                                color: Colors.white54,
                                child: const Text(
                                  "...                                     ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 200),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Bubble(
                                margin: const BubbleEdges.only(left: 0),
                                nip: BubbleNip.leftBottom,
                                color: Colors.white54,
                                child: Text(
                                  spaGirl.questions[widget.questionId].word,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 20),
                                ),
                              ))
                        ],
                      )),
                      SizedBox(
                          width: 150, child: Image.asset(spaGirl.imageSrc)),
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GirlsSelectionPage(),
                    ));
              },
              label: const Text(
                '戻る',
                style: TextStyle(fontSize: 25),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white54)),
              icon:
                  const Icon(Icons.arrow_back, color: Colors.white60, size: 30),
            )));
  }
}
