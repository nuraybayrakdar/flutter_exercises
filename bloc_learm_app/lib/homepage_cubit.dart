import 'package:bloc_learm_app/counting_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<int> {
  HomePageCubit() : super(0);
  var mrepo = CountingRepository();

  void toplama(String input1, String input2) {
    emit(mrepo.topla(input1, input2));
  }

  void carpma(String input1, String input2) {
    emit(mrepo.carp(input1, input2));
  }
}
