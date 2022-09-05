import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  String myHand = '✊';
  String computerHand = '';
  String result = 'じゃんけんスタート！';
  List<String> hands = ['✊', '✌️', '✋'];

  void selectHand(String hand) {
    myHand = hand;
    generateComputerHandIndex();
    judge();
    setState(() {});
  }

  void judge() {
    const wordWin = '勝ち！';
    const wordLose = '負け！';
    if (myHand == computerHand) {
      result = '引き分け';
    } else if (myHand == hands[0]) {
      if (computerHand == hands[1]) {
        result = wordWin;
      } else {
        result = wordLose;
      }
    } else if (myHand == hands[1]) {
      if (computerHand == hands[2]) {
        result = wordWin;
      } else {
        result = wordLose;
      }
    } else if (myHand == hands[2]) {
      if (computerHand == hands[0]) {
        result = wordWin;
      } else {
        result = wordLose;
      }
    }
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return hands[0];
      case 1:
        return hands[1];
      case 2:
        return hands[2];
      default:
        return hands[0];
    }
  }

  String generateComputerHandIndex() {
   final handIndex = Random().nextInt(3);
   computerHand = randomNumberToHand(handIndex);
   return computerHand;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('じゃんけん'),),
      body: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, style: TextStyle(fontSize: 32),),
            SizedBox(height: 32,),
            Text(computerHand, style: TextStyle(fontSize: 32),),
            SizedBox(height: 32,),
            Text(myHand, style: TextStyle(fontSize: 32),),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  selectHand('✊');
                }, child: Text('✊', style: TextStyle(fontSize: 20),),),
                ElevatedButton(onPressed: (){
                  selectHand('✌️');
                }, child: Text('✌️'),),
                ElevatedButton(onPressed: (){
                  selectHand('✋');
                }, child: Text('✋'),),
              ],
            ),
          ],
        ),),
    );
  }
}
