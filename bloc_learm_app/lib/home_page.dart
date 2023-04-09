import 'package:bloc_learm_app/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tfsayi1 = TextEditingController();
  var tfsayi2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Useage"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<HomePageCubit, int>(
                builder: (context, sonuc) {
                  return Text(
                    sonuc.toString(),
                    style: const TextStyle(fontSize: 30),
                  );
                },
              ),
              TextField(
                controller: tfsayi1,
                decoration: const InputDecoration(hintText: "Sayi 1"),
              ),
              TextField(
                controller: tfsayi2,
                decoration: const InputDecoration(hintText: "Sayi 2"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String sayi1 = tfsayi1.text;
                        String sayi2 = tfsayi2.text;
                        context.read<HomePageCubit>().toplama(sayi1, sayi2);
                      },
                      child: const Text("Topla")),
                  ElevatedButton(
                      onPressed: () {
                        String sayi1 = tfsayi1.text;
                        String sayi2 = tfsayi2.text;
                        context.read<HomePageCubit>().carpma(sayi1, sayi2);
                      },
                      child: const Text("Çarp")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
