import 'package:contact_app_bloc/cubit/homepage_cubit.dart';
import 'package:contact_app_bloc/entity/kisiler.dart';
import 'package:contact_app_bloc/views/kisi_detay_view.dart';
import 'package:contact_app_bloc/views/kisi_kayit_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;

  @override
  void initState() {
    context.read<HomePageCubit>().kisileriYukle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                    context.read<HomePageCubit>().kisileriYukle();
                  },
                  icon: const Icon(Icons.cancel_outlined))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
        title: isSearch
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramasonucu) {
                  context.read<HomePageCubit>().search(aramasonucu);
                },
              )
            : const Text("Contacts"),
        backgroundColor: Colors.deepOrange,
      ),
      body: BlocBuilder<HomePageCubit, List<Kisiler>>(
          builder: (context, kisiList) {
        if (kisiList.isNotEmpty) {
          return ListView.builder(
            itemCount: kisiList.length,
            itemBuilder: (context, index) {
              var kisi = kisiList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KisiDetayView(
                                kisi: kisi,
                              ))).then((value) {
                    print("Homepage dönüldü");
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${kisi.kisi_ad} silisin mi?"),
                                action: SnackBarAction(
                                    label: "EVET",
                                    onPressed: () {
                                      context
                                          .read<HomePageCubit>()
                                          .sil(kisi.kisi_id);
                                    }),
                              ));
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.black54,
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center();
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const KisiKayitView())).then((value) {
            print("Homepage dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
