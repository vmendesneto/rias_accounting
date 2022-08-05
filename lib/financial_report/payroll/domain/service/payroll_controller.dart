import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/payroll_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<PayRoll>? payrolls;
  List<int>? empresas = [];
  List<PayRoll>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState(
      {this.payrolls,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate});
}

class PayrollController extends StateNotifier<ViewState> {
  PayrollController([ViewState? state]) : super(ViewState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewState(initialDate: now, endDate: end);
  }

  Future<List<PayRoll>> emp() async {
    List<int> lista = [];
    List<PayRoll> payrolls = await fetchPayroll();
    for (var i = 0; i < payrolls.length;) {
      if (lista.isEmpty) {
        lista.add(payrolls[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(payrolls[i].empresa!)) {
          i++;
        } else {
          lista.add(payrolls[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewState(
        empresas: lista,
        payrolls: payrolls,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return payrolls;
  }

  List<PayRoll>? filter() {
    List<PayRoll>? a = state.payrolls;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<PayRoll>? filters = state.filtered;
    filters!.clear();
    for (var i = 0; i < checks!.length; i++) {
      check = checks[i];
      dado = a!
          .where((e) => e.empresa!.toString().contains(check.toString()))
          .toList();
      if (dado == null) {
      } else {
        for (var i = 0; i < dado.length; i++) {
          if (dado[i].empresa == check) {
            var data = DateTime.parse(dado[i].data!);
            if (data.isBefore(dateF) && data.isAfter(dateI)) {
              print('dado[i]: ${dado[i]}');
              filters.add(dado[i]);
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.data!.compareTo(b.data!));
    state = ViewState(
        empresas: state.empresas,
        payrolls: state.payrolls,
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
        payrolls: state.payrolls,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        payrolls: state.payrolls,
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
          payrolls: state.payrolls,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }
}
