import 'dart:convert';

import 'package:http/http.dart' as http;
//cheer bot
class Answer {
  final String response;

  const Answer({required this.response});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      response: json['response'],
    );
  }
}

Future<Answer> createAnswer(String chat, name) async {
  final response = await http.post(
    Uri.parse('https://beauty-cheer-girls.azurewebsites.net/dialog'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: jsonEncode(<String, String>{
      'chat': chat,
      'name': name,
    }),
  );

  if (response.statusCode == 200) {
    return Answer.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to createAnswer.');
  }
}

/*
// sample usage
void main() {
  String name = "上里 ひなた";
  String chat = "神様について教えて下さい";
  createAnswer(chat, name).then((value) => print(value.response));
}
 */
