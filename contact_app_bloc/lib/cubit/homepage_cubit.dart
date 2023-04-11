// ignore_for_file: non_constant_identifier_names

import 'package:contact_app_bloc/entity/kisiler.dart';
import 'package:contact_app_bloc/repo/kisilerdao_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<List<Kisiler>> {
  HomePageCubit() : super(<Kisiler>[]);

  var kRepo = KisilerDaoRepository();
  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler");
  Future<void> kisileriYukle() async {
    refKisiler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as dynamic;
      if (gelenDegerler != null) {
        var list = <Kisiler>[];
        gelenDegerler.forEach((key, nesne) {
          var kisi = Kisiler.fromJson(key, nesne);
          list.add(kisi);
        });
        emit(list);
      }
    });
  }

  Future<void> search(String aramaKelimesi) async {
    refKisiler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as dynamic;
      if (gelenDegerler != null) {
        var list = <Kisiler>[];
        gelenDegerler.forEach((key, nesne) {
          var kisi = Kisiler.fromJson(key, nesne);
          if (kisi.kisi_ad.contains(aramaKelimesi)) {
            list.add(kisi);
          }
        });
        emit(list);
      }
    });
  }

  Future<void> sil(String kisi_id) async {
    await kRepo.kisiSil(kisi_id);
    await kisileriYukle();
  }
}
