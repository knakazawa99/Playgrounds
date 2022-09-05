
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({Key? key}) : super(key: key);

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {

  List<PixabayImage> pixabayImages = [];

  Future<void> shareImage(String url) async {
    final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final dir = await getTemporaryDirectory();
    final file = await File("${dir.path}/image.png").writeAsBytes(response.data);
    Share.shareFiles([file.path]);
  }

  Future<void> fetchImages(String text) async {
    final response = await Dio().get('https://pixabay.com/api/?key=29672377-a6c08307561b216f5aaf587d7&q=$text&image_type=photo&per_page=100');
    final List hits = response.data['hits'];
    pixabayImages = hits.map((e) {
      return PixabayImage.fromMap(e);
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchImages('blue flower');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: '花',
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            fetchImages(text);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(z
        child: Row(
          children: [
            Icon(Icons.settings),
          ],
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: pixabayImages.length,
          itemBuilder: (context, index) {
            final pixabayImage = pixabayImages[index];
            return InkWell(
              onTap: () async {
                await shareImage(pixabayImage.webFormatURL);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(pixabayImage.previewURL, fit: BoxFit.cover,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.thumb_up_alt_outlined, size: 14),
                          Text("${pixabayImage.likes}"),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}

class PixabayImage {
  final String webFormatURL;
  final String previewURL;
  final int likes;

  PixabayImage({
    required this.webFormatURL,
    required this.previewURL,
    required this.likes
  });

  factory PixabayImage.fromMap(Map<String, dynamic> map) {
    return PixabayImage(webFormatURL: map['webformatURL'], previewURL: map['previewURL'], likes: map['likes']);
  }
}