// ignore_for_file: non_constant_identifier_names

import 'package:contact_app_bloc/entity/kisiler.dart';
import 'package:firebase_database/firebase_database.dart';

class KisilerDaoRepository {
  var refKisiler = FirebaseDatabase.instance.ref().child("kisiler");
  Future<void> kisiKayit(String kisi_ad, String kisi_tel) async {
    var info = Map<String, dynamic>();
    info["kisi_id"] = "";
    info["kisi_ad"] = kisi_ad;
    info["kisi_tel"] = kisi_tel;
    refKisiler.push().set(info);
  }

  Future<void> kisiUpdate(
      String kisi_id, String kisi_ad, String kisi_tel) async {
    var info = Map<String, dynamic>();
    info["kisi_ad"] = kisi_ad;
    info["kisi_tel"] = kisi_tel;
    refKisiler.child(kisi_id).update(info);
  }

  Future<void> kisiSil(String kisi_id) async {
    refKisiler.child(kisi_id).remove();
  }
}
