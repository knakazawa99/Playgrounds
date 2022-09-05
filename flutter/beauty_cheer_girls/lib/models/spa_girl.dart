import 'dart:ui';

import 'package:beauty_cheer_girls/api/aitalk.dart';

class GirlName {
  final String name;
  final String roman;

  GirlName({required this.name, required this.roman});
}

enum QuestionType { sad, pleasure, anger }

class Question {
  final QuestionType type;
  final String word;
  final String? answer;
  final EmotionType answerType;

  Question(
      {required this.type,
      required this.word,
      required this.answerType,
      this.answer});
}

class SpaGirl {
  final GirlName name;
  final int girlId;
  final String imageSrc;
  final String dialogue;
  final String uwakiVoice;
  final String characterTextName;
  final List<Question> questions;
  final int atmosphere;
  final int hairType;
  final int personality;
  final AITalkClient aitalk;
  final Color color;

  SpaGirl({
    required this.name,
    required this.girlId,
    required this.imageSrc,
    required this.dialogue,
    required this.uwakiVoice,
    required this.characterTextName,
    required this.questions,
    required this.atmosphere,
    required this.hairType,
    required this.personality,
    required this.aitalk,
    required this.color,
  });
}

class SpaGirls {
  List<SpaGirl> create() {
    // TODO それぞれの属性に合わせて声質を変える
    return [
      SpaGirl(
        name: GirlName(name: '登別 綾瀬', roman: 'Ayase Nooboribetsu'),
        color: const Color.fromRGBO(105, 210, 248, 1),
        girlId: 0,
        imageSrc: 'assets/images/noboribetsu_ayase.png',
        dialogue: '私にどうして欲しい?',
        uwakiVoice: '違う子の所にいっちゃうんだ',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '慰めてください',
              answer: '最近頑張りすぎてるんじゃない？温泉に入ってゆっくり休もう。\nよかったら…',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '微笑んでみてほしいです',
              answer: 'ふふ、これでいいの？',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '叱られたい',
              answer: 'こら！お姉さんをからかうんじゃありません！',
              answerType: EmotionType.anger),
        ],
        atmosphere: 2,
        hairType: 2,
        personality: 2,
        aitalk: AITalkClient(speakerName: 'aoi_emo', speed: 0.9, pitch: 1.1),
      ),
      SpaGirl(
        name: GirlName(name: '秋保 那菜子', roman: 'Nanako Akiu'),
        color: const Color.fromRGBO(155, 220, 120, 1),
        girlId: 1,
        imageSrc: 'assets/images/akiu_nanako.png',
        dialogue: '私にどうして欲しいですか?',
        uwakiVoice: 'えー、行っちゃうんですか？',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '慰めて',
              answer: '何かあったんですか？\n私でよければなんでも話して下さい！',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '何かいいことあった？',
              answer: '昨日食べた秋保のおはぎがすっごく美味しかったんです！',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '怒ってみて',
              answer: 'ちゃんと栄養のあるもの食べないとダメですよ！私が作り方教えてあげますから、料理しましょう！',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 2,
        aitalk: AITalkClient(
            speakerName: 'maki_emo', speed: 1.1, pitch: 1.5, range: 1.3),
      ),
      SpaGirl(
        name: GirlName(name: '道後 泉海', roman: 'Izumi Dogo'),
        color: const Color.fromRGBO(250, 181, 80, 1),
        girlId: 2,
        imageSrc: 'assets/images/dogo_izumi.png',
        dialogue: '私にどうして欲しいですの?',
        uwakiVoice: '私のことは遊びだったんですの',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '慰めてください',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '笑ってください',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '怒ってください',
              answerType: EmotionType.anger),
        ],
        atmosphere: 2,
        hairType: 1,
        personality: 2,
        aitalk:
            AITalkClient(speakerName: 'akane_west_emo', speed: 0.9, pitch: 1.2),
      ),
      SpaGirl(
        name: GirlName(name: '箱根 彩耶', roman: 'Saya Hakone'),
        color: const Color.fromRGBO(168, 55, 118, 1),
        girlId: 3,
        imageSrc: 'assets/images/hakone_saya.png',
        dialogue: '私にどうして欲しいんだ?',
        uwakiVoice: '寂しいからいっちゃだめだ',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '慰めてほしいな',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '笑顔が見たいな',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: 'ムスッとしてみて',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 1,
        aitalk: AITalkClient(
            speakerName: 'kaho_emo',
            volume: 1.2,
            speed: 1.2,
            pitch: 1.2,
            range: 1.2),
      ),
      SpaGirl(
        name: GirlName(name: 'スクヒナコ', roman: 'Sukihinako'),
        color: const Color.fromRGBO(221, 221, 221, 1),
        girlId: 4,
        imageSrc: 'assets/images/sukunahiko.png',
        dialogue: 'わしにどうして欲しいのじゃ?',
        uwakiVoice: 'わしを置いていくのか？',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: 'どうしたらいいでしょうか？',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '喜ばせてください',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '叱ってください',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 1,
        personality: 1,
        aitalk: AITalkClient(speakerName: 'siori_emo'),
      ),
      SpaGirl(
        name: GirlName(name: '潤目 アリア', roman: 'Aria Urume'),
        color: const Color.fromRGBO(0, 191, 255, 1),
        girlId: 5,
        imageSrc: 'assets/images/urume_aria.png',
        dialogue: '私にどうして欲しいですか?',
        uwakiVoice: 'お姉さんのことはほったらかしですか？',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '元気づけて下さい',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '笑顔下さい',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '蔑んでください',
              answerType: EmotionType.anger),
        ],
        atmosphere: 2,
        hairType: 2,
        personality: 1,
        aitalk: AITalkClient(),
      ),
      SpaGirl(
        name: GirlName(name: '有馬 楓花', roman: 'Fuuka Arima'),
        color: const Color.fromRGBO(228, 169, 187, 1),
        girlId: 6,
        imageSrc: 'assets/images/arima_fuuka.png',
        dialogue: '私どうしたらいいの?',
        uwakiVoice: '待ってよーー',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '元気頂戴',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '笑ってみて',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: 'ぬいぐるみ捨てちゃった',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 2,
        aitalk: AITalkClient(),
      ),
      SpaGirl(
        name: GirlName(name: '有馬 輪花', roman: 'Rinka Arima'),
        color: const Color.fromRGBO(245, 164, 145, 1),
        girlId: 7,
        imageSrc: 'assets/images/arima_rinka.png',
        dialogue: '私にどうしてほしいわけ？',
        uwakiVoice: '別に帰ってこうなくてもいいんだからね',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: 'ちょっと疲れちゃった',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: 'みてみて〜勃っちゃった〜',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '笑ってみて',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 1,
        personality: 1,
        aitalk: AITalkClient(),
      ),
      SpaGirl(
        name: GirlName(name: '下呂 美月', roman: 'Mitsuki Gero'),
        color: const Color.fromRGBO(122, 185, 255, 1),
        girlId: 8,
        imageSrc: 'assets/images/gero_mitsuki.png',
        dialogue: '私にどうして欲しいんですか?',
        uwakiVoice: '違う子のとこにいっちゃうんだ',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: 'なんだか悲しいなぁ',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: 'なんか良いことあった？',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '落胆しちゃった',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 2,
        aitalk: AITalkClient(),
      ),
      SpaGirl(
        name: GirlName(name: '奏・バーデン・由布院', roman: 'Yufuin Baden Kanade'),
        color: const Color.fromRGBO(255, 176, 215, 1),
        girlId: 9,
        imageSrc: 'assets/images/kanade_baden_yufuin.png',
        dialogue: '私にどうして欲しいネ?',
        uwakiVoice: '違う子のとこにいっちゃうんだ',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '慰められたいねネ',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '喜んでほしいネ',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: '叱られたいネ',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 1,
        aitalk: AITalkClient(),
      ),
      SpaGirl(
        name: GirlName(name: '草津 結衣奈', roman: 'Yuina Kusatsu'),
        color: const Color.fromRGBO(242, 220, 89, 1),
        girlId: 10,
        imageSrc: 'assets/images/kusatsu_yuina.png',
        dialogue: 'なんでも言ってみて！',
        uwakiVoice: '違う子のとこにいっちゃうんだ',
        characterTextName: '結城 友奈',
        questions: [
          Question(
              type: QuestionType.sad,
              word: '温泉入りたいなぁ',
              answerType: EmotionType.normal),
          Question(
              type: QuestionType.pleasure,
              word: '温泉饅頭食べる？',
              answerType: EmotionType.pleasure),
          Question(
              type: QuestionType.anger,
              word: 'タイ料理屋行こう？',
              answerType: EmotionType.anger),
        ],
        atmosphere: 1,
        hairType: 2,
        personality: 1,
        aitalk: AITalkClient(),
      ),
    ];
  }
}
