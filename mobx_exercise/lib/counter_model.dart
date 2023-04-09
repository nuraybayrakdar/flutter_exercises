import 'package:mobx/mobx.dart';
part 'counter_model.g.dart';

class CounterModel = CounterModelBase with _$CounterModel;

abstract class CounterModelBase with Store {
  @observable
  int counter = 0;

  @action
  void counterArttir() {
    counter = counter + 1;
  }

  @action
  void counterAzalt(int miktar) {
    counter = counter - miktar;
  }
}
