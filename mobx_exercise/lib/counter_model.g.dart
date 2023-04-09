// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CounterModel on CounterModelBase, Store {
  late final _$counterAtom =
      Atom(name: 'CounterModelBase.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$CounterModelBaseActionController =
      ActionController(name: 'CounterModelBase', context: context);

  @override
  void counterArttir() {
    final _$actionInfo = _$CounterModelBaseActionController.startAction(
        name: 'CounterModelBase.counterArttir');
    try {
      return super.counterArttir();
    } finally {
      _$CounterModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void counterAzalt(int miktar) {
    final _$actionInfo = _$CounterModelBaseActionController.startAction(
        name: 'CounterModelBase.counterAzalt');
    try {
      return super.counterAzalt(miktar);
    } finally {
      _$CounterModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
