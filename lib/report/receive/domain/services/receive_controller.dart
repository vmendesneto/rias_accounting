import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receive_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Receive>? receives;
  List<int>? empresas = [];

  ViewState({this.receives, this.check, this.isChecked = false, this.empresas});
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
    state = ViewState(
        empresas: lista,
        receives: test,
        isChecked: state.isChecked,
        check: state.check);
    return test;
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
