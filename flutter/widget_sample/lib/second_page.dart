import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  SecondPage(this.name, {Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kensuke'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(10), child: Image.asset('assets/images/test.jpg'),),
            Text(name,
            style: const TextStyle(fontSize: 30),),
            ElevatedButton(
              onPressed: () {
                // action at push
              },
              child: const Text("Second"),
            ),
          ],
        ),
      ),
    );
  }

}