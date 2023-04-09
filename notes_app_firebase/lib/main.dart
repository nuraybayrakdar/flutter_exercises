import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/note_detail_page.dart';
import 'package:notes_app_firebase/note_record_page.dart';
import 'package:notes_app_firebase/notes.dart';

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
  var refNotes = FirebaseDatabase.instance.ref().child("notlar");

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
              StreamBuilder<DatabaseEvent>(
                  stream: refNotes.onValue,
                  builder: (context, event) {
                    if (event.hasData) {
                      var notesList = <Notes>[];
                      var gelenDegerler = event.data!.snapshot.value as dynamic;

                      if (gelenDegerler != null) {
                        gelenDegerler.forEach((key, obj) {
                          var gelenNot = Notes.fromJson(key, obj);
                          notesList.add(gelenNot);
                        });
                      }

                      double ort = 0.0;
                      if (notesList.isNotEmpty) {
                        double sum = 0.0;
                        for (var n in notesList) {
                          sum = sum + (n.not1 + n.not2) / 2;
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
        child: StreamBuilder<DatabaseEvent>(
          stream: refNotes.onValue,
          builder: (context, event) {
            if (event.hasData) {
              var notesList = <Notes>[];
              var gelenDegerler = event.data!.snapshot.value as dynamic;

              if (gelenDegerler != null) {
                gelenDegerler.forEach((key, obj) {
                  var gelenNot = Notes.fromJson(key, obj);
                  notesList.add(gelenNot);
                });
              }
              return ListView.builder(
                  itemCount: notesList.length,
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
