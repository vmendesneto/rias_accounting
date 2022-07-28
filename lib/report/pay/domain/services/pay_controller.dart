import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/pay_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Pay>? pays;
  List<int>? empresas = [];
  List<Pay>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState(
      {this.pays,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate});
}

class PayController extends StateNotifier<ViewState> {
  PayController([ViewState? state]) : super(ViewState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewState(initialDate: now, endDate: end);
  }

  Future<List<Pay>> emp() async {
    List<int> lista = [];
    List<Pay> pays = await fetchPay();
    for (var i = 0; i < pays.length;) {
      if (lista.isEmpty) {
        lista.add(pays[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(pays[i].empresa!)) {
          i++;
        } else {
          lista.add(pays[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewState(
        empresas: lista,
        pays: pays,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return pays;
  }

  List<Pay>? filter() {
    List<Pay>? a = state.pays;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Pay>? filters = state.filtered;
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
            var dataPgto = DateTime.parse(dado[i].datapagamento!);
            if (dataPgto.isBefore(dateF) && dataPgto.isAfter(dateI)) {
              print('dado[i]: ${dado[i]}');
              filters.add(dado[i]);
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.datapagamento!.compareTo(b.datapagamento!));
    state = ViewState(
        empresas: state.empresas,
        pays: state.pays,
        check: state.check,
        filtered: filters,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return filters;
  }

  trueCheck(int emp) {
    state.check!.add(emp);

    state = ViewState(
        empresas: state.empresas,
        pays: state.pays,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        pays: state.pays,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      var now = args.value.startDate;
      var end = args.value.endDate ?? args.value.startDate;
      state = ViewState(
          initialDate: now,
          endDate: end,
          empresas: state.empresas,
          pays: state.pays,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }
}
