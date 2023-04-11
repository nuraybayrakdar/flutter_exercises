// ignore_for_file: non_constant_identifier_names

import 'package:contact_app_bloc/repo/kisilerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KisiKayitCubit extends Cubit {
  KisiKayitCubit() : super(0);

  var kRepo = KisilerDaoRepository();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await kRepo.kisiKayit(kisi_ad, kisi_tel);
  }
}
