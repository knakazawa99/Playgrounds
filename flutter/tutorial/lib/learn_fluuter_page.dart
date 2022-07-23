import 'package:flutter/material.dart';

class LearnFluuterPage extends StatefulWidget {
  const LearnFluuterPage({Key? key}) : super(key: key);

  @override
  State<LearnFluuterPage> createState() => _LearnFluuterPageState();
}

class _LearnFluuterPageState extends State<LearnFluuterPage> {
  bool isSwitch = false;
  bool isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Flutter'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint('Actions');
              },
              icon: const Icon(Icons.info_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset('images/einstein.jpeg'),
          const SizedBox(
            height: 7,
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.blueGrey,
            width: double.infinity,
            child: const Center(
              child: Text(
                'This is a text widget',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isSwitch ? Colors.green : Colors.blue),
              onPressed: () {
                debugPrint('Elevated Button');
              },
              child: const Text('Elevated Button')),
          OutlinedButton(
              onPressed: () {
                debugPrint('Outlined Button');
              },
              child: const Text('Outlined Button')),
          TextButton(
              onPressed: () {
                debugPrint('Text Button');
              },
              child: const Text('Text Button')),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              debugPrint('This is the row');
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                  Text('Row widget'),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                ]),
          ),
          Switch(
              value: isSwitch,
              onChanged: (bool newBool) {
                setState(() {
                  isSwitch = newBool;
                });
              }),
          Checkbox(
              value: isCheckBox,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheckBox = newBool!;
                });
              }),
          Checkbox(
            value: isCheckBox,
            onChanged: (bool? newBool) {
              setState(() {
                isCheckBox = newBool!;
              });
            },
          ),
          Image.network(
              "https://images.saatchiart.com/saatchi/300119/art/2565930/1635850-HSC00001-7.jpg"),
        ]),
      ),
    );
  }
}
