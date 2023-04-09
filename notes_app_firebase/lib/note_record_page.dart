// ignore_for_file: library_private_types_in_public_api

import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase/main.dart';

class NotesRecordPage extends StatefulWidget {
  const NotesRecordPage({super.key});

  @override
  _NotesRecordPageState createState() => _NotesRecordPageState();
}

class _NotesRecordPageState extends State<NotesRecordPage> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();
  var refNotes = FirebaseDatabase.instance.ref().child("notlar");
  Future<void> kayit(String ders_adi, int not1, int not2) async {
    var info = HashMap<String, dynamic>();
    info["not_id"] = "";
    info["ders_adi"] = ders_adi;
    info["not1"] = not1;
    info["not2"] = not2;
    refNotes.push().set(info);
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
