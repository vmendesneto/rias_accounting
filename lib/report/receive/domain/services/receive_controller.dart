import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receive_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Receive>? receives;
  List<int>? empresas = [];
  List<Receive>? filtered;

  ViewState({this.receives, this.check, this.isChecked = false, this.empresas, this.filtered});
}

class ReceiveController extends StateNotifier<ViewState> {
  ReceiveController([ViewState? state]) : super(ViewState());

  Future<List<Receive>> emp() async {
    List<int> lista = [];
    List<Receive> test = await fetchReceive();
    for (var i = 0; i < test.length;) {
      if (lista.isEmpty) {
        lista.add(test[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(test[i].empresa!)) {
          i++;
        } else {
          lista.add(test[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??=[];
    state = ViewState(
        empresas: lista,
        receives: test,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered);
    return test;
  }
  List<Receive>? filter () {
    List<Receive>? test = state.receives;
    var dado;
    var check;

    List<Receive>? testando;
    for (var i = 0; i < state.check!.length; i++) {
      check = state.check![i];
        print("check : ${state.check}");
        print(test![i].empresa);
        dado = test.where((e) =>
            e.empresa!.toString().contains(check.toString())).toList();
        if (dado == null || testando == null) {
          testando = dado;
        } else{
          for(var i =0; i < dado.length;i++){
            print('dado[i]: ${dado[i]}');
            testando.add(dado[i]);
          }
        }
    }
    //ORDENANDO POR DATA DE PG
   testando!.sort((a,b) => a.data_pagamento!.compareTo(b.data_pagamento!));
      state = ViewState(
          empresas: state.empresas,
          receives: state.receives,
          check: state.check,
          filtered: testando);
      return testando;
  }
  trueCheck(int emp) {
    state.check!.add(emp);

    state = ViewState(
        empresas: state.empresas, receives: state.receives, check: state.check);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas, receives: state.receives, check: state.check);
  }
}
