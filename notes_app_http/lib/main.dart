import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notes_app_http/note_detail_page.dart';
import 'package:notes_app_http/note_record_page.dart';
import 'package:notes_app_http/notes.dart';
import 'package:notes_app_http/notes_response.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Notes> parseNotesResponse(String response) {
    return NotesResponse.fromJson(json.decode(response)).noteList;
  }

  Future<List<Notes>> showAllNotes() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/tum_notlar.php");
    var res = await http.get(url);
    return parseNotesResponse(res.body);
  }

  Future<bool> powerOff() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: powerOff,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notlarım",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              FutureBuilder(
                  future: showAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var notesList = snapshot.data;
                      double ort = 0.0;
                      if (notesList!.isNotEmpty) {
                        double sum = 0.0;
                        for (var n in notesList) {
                          sum = sum + (int.parse(n.not1 + n.not2)) / 2;
                        }
                        ort = sum / notesList.length;
                      }
                      return Text(
                        "Ortalama: ${ort.toInt()}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      );
                    } else {
                      return const Text(
                        "Ortalama: 0",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      );
                    }
                  })
            ],
          )),
      body: WillPopScope(
        onWillPop: powerOff,
        child: FutureBuilder<List<Notes>>(
          future: showAllNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notesList = snapshot.data;
              return ListView.builder(
                  itemCount: notesList!.length,
                  itemBuilder: (context, index) {
                    var not = notesList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotesDetailPage(not: not),
                            ));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                not.ders_adi,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(not.not1.toString()),
                              Text(not.not2.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesRecordPage(),
              ));
        },
        tooltip: 'Not Ekle',
        icon: const Icon(Icons.add),
        label: const Text("Kaydet"),
      ),
    );
  }
}
