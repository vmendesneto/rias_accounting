import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/financial_report/receive/domain/services/receive_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/devolution_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Devolution>? devolutions;
  List<int>? empresas = [];
  List<Devolution>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState(
      {this.devolutions,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate});
}

class DevolutionController extends StateNotifier<ViewState> {
  DevolutionController([ViewState? state]) : super(ViewState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewState(initialDate: now, endDate: end);
  }

  Future<List<Devolution>> emp() async {
    List<int> lista = [];
    List<Devolution> devolutions = await fetchDevolution();
    for (var i = 0; i < devolutions.length;) {
      if (lista.isEmpty) {
        lista.add(devolutions[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(devolutions[i].empresa!)) {
          i++;
        } else {
          lista.add(devolutions[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewState(
        empresas: lista,
        devolutions: devolutions,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return devolutions;
  }

  List<Devolution>? filter() {
    List<Devolution>? a = state.devolutions;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Devolution>? filters = state.filtered;
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
            var dataLanc = DateTime.parse(dado[i].dataLancamento!);
            if (dataLanc.isBefore(dateF) && dataLanc.isAfter(dateI)) {
              print('dado[i]: ${dado[i]}');
              filters.add(dado[i]);
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.dataLancamento!.compareTo(b.dataLancamento!));
    state = ViewState(
        empresas: state.empresas,
        devolutions: state.devolutions,
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
        devolutions: state.devolutions,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        devolutions: state.devolutions,
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
          devolutions: state.devolutions,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }

  filterAccount() {
    ViewReceiveState checkReceive = ViewReceiveState();
    num total = 0;
    List<Devolution>? a = state.devolutions;
    var dado;
    var checks = state.check;
    var check;
    var month = DateTime.now().month - 1;
    List fatDevolution = [];
    for (var i = 0; i < checks!.length; i++) {
      check = checks[i];
      dado = a!
          .where((e) => e.empresa!.toString().contains(check.toString()))
          .toList();
      if (dado == null) {
      } else {
        for (var i = 0; i < dado.length; i++) {
          if (dado[i].empresa == check) {
            var dataLanc = DateTime.parse(dado[i].dataLancamento!);
            if (dataLanc.month == month) {
              print('dado[i]: ${dado[i]}');
              fatDevolution.add(dado[i].valor);
            } else {}
          }
        }
      }
    }
    for (var i = 0; i < fatDevolution.length; i++) {
      total = total + fatDevolution[i];
    }
    state = ViewState(
        empresas: state.empresas,
        devolutions: state.devolutions,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return total;
  }
}
