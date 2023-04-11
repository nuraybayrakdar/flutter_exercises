// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:contact_app_bloc/cubit/kisi_detay_cubit.dart';
import 'package:contact_app_bloc/entity/kisiler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KisiDetayView extends StatefulWidget {
  Kisiler kisi;
  KisiDetayView({super.key, required this.kisi});
  @override
  State<KisiDetayView> createState() => _KisiDetayViewState();
}

class _KisiDetayViewState extends State<KisiDetayView> {
  var tfname = TextEditingController();
  var tftel = TextEditingController();

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfname.text = kisi.kisi_ad;
    tftel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kişi Detay"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: tfname,
                  decoration: const InputDecoration(hintText: "Kişi Ad"),
                ),
                TextField(
                  controller: tftel,
                  decoration: const InputDecoration(hintText: "Kişi Tel"),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<KisiDetayCubit>().update(widget.kisi.kisi_id,
                          widget.kisi.kisi_ad, widget.kisi.kisi_tel);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    child: const Text("Güncelle")),
              ]),
        ),
      ),
    );
  }
}
