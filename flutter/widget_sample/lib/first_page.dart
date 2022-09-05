import 'package:flutter/material.dart';
import 'package:widget_sample/second_page.dart';

class FirstPage extends StatelessWidget {
  String nameText = '';
  final List<String> entries = <String>[
    '【実験体:てつや】１番長くサウナに入れる方法を提案したやつが勝ち！！！',
    '２年半ぶりに復活！「全国４６道府県！旅行の旅！」千葉県編 〜銚子電鉄遠くないか？〜', 'C', 'D'];
  final List<int> colorCodes = <int>[600, 500, 100, 200];

  FirstPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text("Kensuke's Life", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black26,
        actions: const [
          Icon(Icons.cast),
          SizedBox(width: 24),
          Icon(Icons.search),
          SizedBox(width: 24),
          Icon(Icons.menu_outlined),
          SizedBox(width: 24),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Image.network('https://i.ytimg.com/an_webp/snCI_mcsLxo/mqdefault_6s.webp?du=3000&sqp=CPjFx5gG&rs=AOn4CLDa92_7KUouJ6YuoMcX-AhHjFtH9Q'),
                  const SizedBox(width: 16),
                  Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entries[index],
                             style: TextStyle(color: Colors.white, height: 1.3, fontSize: 12)),
                        Text('14万回', style: TextStyle(color: Colors.grey, fontSize: 12))
                      ],
                    )
                  ),
                ],
              ),
            );
          }
      )
    );
  }

}