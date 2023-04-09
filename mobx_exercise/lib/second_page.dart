// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_exercise/counter_model.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  var counterModelObject = CounterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second page")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (_) {
              return Text(
                counterModelObject.counter.toString(),
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
          TextButton(
            child: const Text("Sayaç Arttır"),
            onPressed: () {
              counterModelObject.counterArttir();
            },
          ),
          TextButton(
            child: const Text("Sayaç Azalt"),
            onPressed: () {
              counterModelObject.counterAzalt(2);
            },
          )
        ],
      )),
    );
  }
}
