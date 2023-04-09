// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/notes.dart';
import 'package:notes_app_firebase/main.dart';

class NotesDetailPage extends StatefulWidget {
  Notes not;

  NotesDetailPage({super.key, required this.not});

  @override
  _NotesDetailPageState createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();
  var refNotes = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> sil(String not_id) async {
    refNotes.child(not_id).remove();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  Future<void> guncelle(
      String not_id, String ders_adi, int not1, int not2) async {
    var info = HashMap<String, dynamic>();
    info["ders_adi"] = ders_adi;
    info["not1"] = not1;
    info["not2"] = not2;
    refNotes.child(not_id).update(info);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfnot1.text = not.not1.toString();
    tfnot2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Detay"),
        actions: [
          TextButton(
            child: const Text(
              "Sil",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              sil(widget.not.not_id);
            },
          ),
          TextButton(
            child: const Text(
              "Güncelle",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              guncelle(widget.not.not_id, tfDersAdi.text,
                  int.parse(tfnot1.text), int.parse(tfnot2.text));
            },
          ),
        ],
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
    );
  }
}
