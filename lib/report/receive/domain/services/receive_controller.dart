import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../models/receive_model.dart';
import 'package:intl/intl.dart';


class ViewState {
  bool isChecked;
  List<int>? check;
  List<Receive>? receives;
  List<int>? empresas = [];
  List<Receive>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState({this.receives, this.check, this.isChecked = false, this.empresas, this.filtered, this.initialDate, this.endDate});
}

class ReceiveController extends StateNotifier<ViewState> {
  ReceiveController([ViewState? state]) : super(ViewState());

  void dateInitial(){
    var now = DateTime.now().subtract(const Duration(days: 4));
   var end = DateTime.now().add(const Duration(days: 0));
   state = ViewState(initialDate: now, endDate: end);
  }

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
        filtered: state.filtered, initialDate: state.initialDate, endDate: state.endDate);
    return test;
  }
  List<Receive>? filter () {
    List<Receive>? test = state.receives;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Receive>? testando = state.filtered;
    testando!.clear();
    for (var i = 0; i < checks!.length; i++) {
      check = checks[i];
        dado = test!.where((e) =>
            e.empresa!.toString().contains(check.toString())).toList();
               if (dado == null) {
              //fazer função pra receiverScreen ser informada que não a lançamentos
               } else {
                for (var i = 0; i < dado.length; i++) {
                  var dataPgto = DateTime.parse(dado[i].data_pagamento!);
                  if (dataPgto.isBefore(dateF) && dataPgto.isAfter(dateI)) {
                    print('dado[i]: ${dado[i]}');
                    testando.add(dado[i]);
                  }else{
                  }
              }
            }
    }
    //ORDENANDO POR DATA DE PG
   testando.sort((a,b) => a.data_pagamento!.compareTo(b.data_pagamento!));
      state = ViewState(
          empresas: state.empresas,
          receives: state.receives,
          check: state.check,
          filtered: testando, initialDate: state.initialDate, endDate: state.endDate);
      return testando;
  }
  trueCheck(int emp) {
    state.check!.add(emp);

    state = ViewState(
        empresas: state.empresas, receives: state.receives, check: state.check, endDate: state.endDate, filtered: state.filtered, initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas, receives: state.receives, check: state.check, endDate: state.endDate, filtered: state.filtered, initialDate: state.initialDate);
  }



  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      if (args.value is PickerDateRange) {
        var now = args.value.startDate;
        var end = args.value.endDate ?? args.value.startDate;
        state = ViewState(initialDate: now,endDate: end,empresas: state.empresas,
            receives: state.receives,
            check: state.check, filtered: state.filtered, isChecked: state.isChecked);
      }
  }
}
