import 'dart:convert';

import 'package:dictionary_app/detailpage.dart';
import 'package:dictionary_app/words.dart';
import 'package:dictionary_app/wordsResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;
  String searchWord = "";

  List<Words> parseWordsResponse(String response) {
    return WordsResponse.fromJson(json.decode(response)).wordList;
  }

  Future<List<Words>> showAllWords() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php");
    var response = await http.get(url);

    return parseWordsResponse(response.body);
  }

  Future<List<Words>> searchingWord(String searchWord) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/sozluk/kelime_ara.php");
    var data = {"ingilizce": searchWord};
    var response = await http.post(url, body: data);

    return parseWordsResponse(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isSearch
              ? TextField(
                  decoration: const InputDecoration(hintText: "Search.."),
                  onChanged: (searchResult) {
                    print("result: $searchResult");
                    setState(() {
                      searchWord = searchResult;
                    });
                  },
                )
              : const Text("Dictionary"),
          actions: [
            isSearch
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = false;
                        searchWord = "";
                      });
                    },
                    icon: const Icon(Icons.cancel))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });
                    },
                    icon: const Icon(Icons.search))
          ],
        ),
        body: FutureBuilder<List<Words>>(
            future: isSearch ? searchingWord(searchWord) : showAllWords(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var wordsList = snapshot.data;
                return ListView.builder(
                  itemCount: wordsList!.length,
                  itemBuilder: (context, index) {
                    var word = wordsList[index];
                    return SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        word: word,
                                      )));
                        },
                        child: Card(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  word.ingilizce,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(word.turkce),
                              ]),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center();
              }
            }));
  }
}
