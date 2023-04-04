import 'package:dictionary_app_firebase/detailpage.dart';
import 'package:dictionary_app_firebase/words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  var refKelimeler = FirebaseDatabase.instance.ref().child("kelimeler");

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
        body: StreamBuilder<DatabaseEvent>(
            stream: refKelimeler.onValue,
            builder: (context, event) {
              if (event.hasData) {
                var wordsList = <Words>[];
                var gelenDegerler = event.data!.snapshot.value as dynamic;
                if (gelenDegerler != null) {
                  gelenDegerler.forEach((key, nesne) {
                    var gelenWord = Words.fromJson(key, nesne);

                    if (isSearch) {
                      if (gelenWord.ingilizce.startsWith(searchWord)) {
                        wordsList.add(gelenWord);
                      }
                    } else {
                      wordsList.add(gelenWord);
                    }
                  });
                }
                return ListView.builder(
                  itemCount: wordsList.length,
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
