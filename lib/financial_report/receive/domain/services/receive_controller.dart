import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../models/receive_model.dart';
import 'package:collection/collection.dart';

class ViewReceiveState {
  bool isChecked;
  List<int>? check;
  List<Receive>? receives;
  List<int>? empresas = [];
  List<Receive>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewReceiveState({
    this.receives,
    this.check,
    this.isChecked = false,
    this.empresas,
    this.filtered,
    this.initialDate,
    this.endDate,
  });
}

class ReceiveController extends StateNotifier<ViewReceiveState> {
  ReceiveController([ViewReceiveState? state]) : super(ViewReceiveState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewReceiveState(initialDate: now, endDate: end);
  }

  Future<List<Receive>> emp() async {
    List<int> lista = [];
    List<Receive> receives = await fetchReceive();
    for (var i = 0; i < receives.length;) {
      if (lista.isEmpty) {
        lista.add(receives[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(receives[i].empresa!)) {
          i++;
        } else {
          lista.add(receives[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewReceiveState(
      empresas: lista,
      receives: receives,
      isChecked: state.isChecked,
      check: state.check,
      filtered: state.filtered,
      initialDate: state.initialDate,
      endDate: state.endDate,
    );
    return receives;
  }

  List<Receive>? filter() {
    List<Receive>? a = state.receives;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Receive>? filters = state.filtered;
    filters!.clear();
    for (var i = 0; i < checks!.length; i++) {
      check = checks[i];
      dado = a!
          .where((e) => e.empresa!.toString().contains(check.toString()))
          .toList();
      if (dado == null) {
        //fazer função pra receiverScreen ser informada que não a lançamentos
      } else {
        for (var i = 0; i < dado.length; i++) {
          if (dado[i].empresa == check) {
            var dataPgto = DateTime.parse(dado[i].data_pagamento!);
            if (dataPgto.isBefore(dateF) && dataPgto.isAfter(dateI)) {
              print('dado[i]: ${dado[i]}');
              filters.add(dado[i]);
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.data_pagamento!.compareTo(b.data_pagamento!));
    state = ViewReceiveState(
      empresas: state.empresas,
      receives: state.receives,
      check: state.check,
      filtered: filters,
      initialDate: state.initialDate,
      endDate: state.endDate,
    );
    return filters;
  }

  trueCheck(int emp) {
    state.check!.add(emp);
    state = ViewReceiveState(
      empresas: state.empresas,
      receives: state.receives,
      check: state.check,
      endDate: state.endDate,
      filtered: state.filtered,
      initialDate: state.initialDate,
    );
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewReceiveState(
        empresas: state.empresas,
        receives: state.receives,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      var now = args.value.startDate;
      var end = args.value.endDate ?? args.value.startDate;
      state = ViewReceiveState(
          initialDate: now,
          endDate: end,
          empresas: state.empresas,
          receives: state.receives,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }

  filterAccount() {
    num total = 0;
    List<Receive>? a = state.receives;
    var dado;
    var checks = state.check;
    var check;
    var month = DateTime.now().month - 1;
    List fatReceives = [];
    for (var i = 0; i < checks!.length; i++) {
      check = checks[i];
      dado = a!
          .where((e) => e.empresa!.toString().contains(check.toString()))
          .toList();
      if (dado == null) {
      } else {
        for (var i = 0; i < dado.length; i++) {
          if (dado[i].empresa == check) {
            var dataPgto = DateTime.parse(dado[i].data_pagamento!);
            if (dataPgto.month == month) {
              fatReceives.add(dado[i].valor_pago);
            } else {}
          }
        }
      }
    }
    for (var i = 0; i < fatReceives.length; i++) {
      total = total + fatReceives[i];
    }
    state = ViewReceiveState(
        empresas: state.empresas,
        receives: state.receives,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return total;
  }
}
