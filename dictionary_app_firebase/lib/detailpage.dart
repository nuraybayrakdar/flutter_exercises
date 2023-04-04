// ignore_for_file: must_be_immutable
import 'package:dictionary_app_firebase/words.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Words word;
  DetailPage({super.key, required this.word});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Detail"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.word.ingilizce,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.pink),
            ),
            Text(
              widget.word.turkce,
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
