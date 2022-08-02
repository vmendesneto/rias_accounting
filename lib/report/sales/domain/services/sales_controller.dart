import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/sales_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Sale>? sales;
  List<int>? empresas = [];
  List<Sale>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState(
      {this.sales,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate});
}

class SaleController extends StateNotifier<ViewState> {
  SaleController([ViewState? state]) : super(ViewState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewState(initialDate: now, endDate: end);
  }

  Future<List<Sale>> emp() async {
    List<int> lista = [];
    List<Sale> sales = await fetchSale();
    for (var i = 0; i < sales.length;) {
      if (lista.isEmpty) {
        lista.add(sales[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(sales[i].empresa!)) {
          i++;
        } else {
          lista.add(sales[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewState(
        empresas: lista,
        sales: sales,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return sales;
  }

  List<Sale>? filter() {
    List<Sale>? a = state.sales;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Sale>? filters = state.filtered;
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
            if(dado[i].ideStatus == 'D'){
            var dataFaturamento = DateTime.parse(dado[i].dataFaturamento!);
            if dataFaturamento.isBefore(dateF) && dataFaturamento.isAfter(dateI)) {
              filters.add(dado[i]);
            } else {}
            }else{}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.dataPedido!.compareTo(b.dataPedido!));
    state = ViewState(
        empresas: state.empresas,
        sales: state.sales,
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
        sales: state.sales,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        sales: state.sales,
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
          sales: state.sales,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }
}
