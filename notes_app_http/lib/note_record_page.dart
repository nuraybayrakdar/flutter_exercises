// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notes_app_http/main.dart';
import 'package:http/http.dart' as http;

class NotesRecordPage extends StatefulWidget {
  const NotesRecordPage({super.key});

  @override
  _NotesRecordPageState createState() => _NotesRecordPageState();
}

class _NotesRecordPageState extends State<NotesRecordPage> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();

  Future<void> kayit(String ders_adi, int not1, int not2) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/notlar/insert_not.php");
    var data = {
      "ders_adi:": ders_adi,
      "not1": not1.toString(),
      "not2": not2.toString()
    };

    var res = await http.post(url, body: data);
    print(res.body);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: const InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfnot1,
                decoration: const InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfnot2,
                decoration: const InputDecoration(hintText: "2. Not"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          kayit(tfDersAdi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
        },
        tooltip: 'Not Kayıt',
        icon: const Icon(Icons.save),
        label: const Text("Kaydet"),
      ),
    );
  }
}
