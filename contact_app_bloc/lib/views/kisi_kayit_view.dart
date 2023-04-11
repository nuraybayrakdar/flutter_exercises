import 'package:contact_app_bloc/cubit/kisi_kayit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KisiKayitView extends StatefulWidget {
  const KisiKayitView({super.key});

  @override
  State<KisiKayitView> createState() => _KisiKayitViewState();
}

class _KisiKayitViewState extends State<KisiKayitView> {
  @override
  Widget build(BuildContext context) {
    var tfname = TextEditingController();
    var tftel = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
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
                      context
                          .read<KisiKayitCubit>()
                          .kayit(tfname.text, tftel.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    child: const Text("Kaydet")),
              ]),
        ),
      ),
    );
  }
}
