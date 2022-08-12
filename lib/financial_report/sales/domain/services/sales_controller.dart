import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/core/global_variables.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import '../models/sales_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Sale>? sales;
  List<int>? empresas = [];
  List<Sale>? filtered;
  DateTime? initialDate;
  DateTime? endDate;
  int? count;
  List<num>? result;
  List<num>? rest;
  List<num>? restFrete;
  List<num>? restCusto;
  List<num>? mes1;
  List<num>? mes2;
  List<num>? mes3;
  List<num>? mes4;
  List<num>? mes5;
  List<num>? mes6;
  List<num>? mes7;
  List<num>? mes8;
  List<num>? mes9;
  List<num>? mes10;
  List<num>? mes11;
  List<num>? mes12;
  List<num>? frete1;
  List<num>? frete2;
  List<num>? frete3;
  List<num>? frete4;
  List<num>? frete5;
  List<num>? frete6;
  List<num>? frete7;
  List<num>? frete8;
  List<num>? frete9;
  List<num>? frete10;
  List<num>? frete11;
  List<num>? frete12;
  List<num>? custo1;
  List<num>? custo2;
  List<num>? custo3;
  List<num>? custo4;
  List<num>? custo5;
  List<num>? custo6;
  List<num>? custo7;
  List<num>? custo8;
  List<num>? custo9;
  List<num>? custo10;
  List<num>? custo11;
  List<num>? custo12;
  ViewState(
      {this.sales,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate,this.count,
        this.frete1,
        this.frete2,
        this.frete3,
        this.frete4,
        this.frete5,
        this.frete6,
        this.frete7,
        this.frete8,
        this.frete9,
        this.frete10,
        this.frete11,
        this.frete12,
        this.mes1,
        this.mes2,
        this.mes3,
        this.mes4,
        this.mes5,
        this.mes6,
        this.mes7,
        this.mes8,
        this.mes9,
        this.mes10,
        this.mes11,
        this.mes12,
        this.custo1,
        this.custo2,
        this.custo3,
        this.custo4,
        this.custo5,
        this.custo6,
        this.custo7,
        this.custo8,
        this.custo9,
        this.custo10,
        this.custo11,
        this.custo12,
        this.rest,
      this.restFrete,
      this.restCusto});
}

class SaleController extends StateNotifier<ViewState> {
  SaleController([ViewState? state]) : super(ViewState());

  Variables variables = Variables();

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
        endDate: state.endDate,
        count: state.count);
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
            if (dado[i].ideStatus == 'D') {
              var dataFaturamento = DateTime.parse(dado[i].dataFaturamento!);
              if (dataFaturamento.isBefore(dateF) &&
                  dataFaturamento.isAfter(dateI)) {
                filters.add(dado[i]);
              } else {}
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.dataFaturamento!.compareTo(b.dataFaturamento!));
    state = ViewState(
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        filtered: filters,
        initialDate: state.initialDate,
        endDate: state.endDate,
        count: state.count);
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
        initialDate: state.initialDate,
        count: state.count);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate,
        count: state.count);
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
  void onSelection(int option) {
    switch (option) {
      case 1:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 1, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = ViewState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 1,
          );
        }
        break;
      case 2:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 3, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = ViewState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 3,

          );
        }
        break;
      case 3:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 6, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = ViewState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 6,

          );
        }
        break;
      case 4:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 12, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = ViewState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 12,

          );
        }
        break;
      case 5:
        {
          var dateInitial =
          DateTime(variables.today.year, 01, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = ViewState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: variables.today.month -1,

          );
        }
        break;
    }
  }

  separateMonth() {
    List<num> mes1 = [];
    List<num> mes2 = [];
    List<num> mes3 = [];
    List<num> mes4 = [];
    List<num> mes5 = [];
    List<num> mes6 = [];
    List<num> mes7 = [];
    List<num> mes8 = [];
    List<num> mes9 = [];
    List<num> mes10 = [];
    List<num> mes11 = [];
    List<num> mes12 = [];
    List<num> frete1 = [];
    List<num> frete2 = [];
    List<num> frete3 = [];
    List<num> frete4 = [];
    List<num> frete5 = [];
    List<num> frete6 = [];
    List<num> frete7 = [];
    List<num> frete8 = [];
    List<num> frete9 = [];
    List<num> frete10 = [];
    List<num> frete11 = [];
    List<num> frete12 = [];
    List<num> custo1 = [];
    List<num> custo2 = [];
    List<num> custo3 = [];
    List<num> custo4 = [];
    List<num>custo5 = [];
    List<num> custo6 = [];
    List<num> custo7 = [];
    List<num> custo8 = [];
    List<num> custo9 = [];
    List<num> custo10 = [];
    List<num> custo11 = [];
    List<num> custo12 = [];
    List<Sale>? filtro = filter();
    for (var i = 0; i < filtro!.length;) {
      if (filtro[i].dataFaturamento != null) {
        DateTime ola = DateTime.parse((filtro[i].dataFaturamento !));
        //colcar na lista do mes certo
        switch (ola.month) {
          case 1:
            {
              mes1.add(filtro[i].valorPedido!);
              frete1.add(filtro[i].frete!);
              custo1.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 2:
            {
              mes2.add(filtro[i].valorPedido!);
              frete2.add(filtro[i].frete!);
              custo2.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 3:
            {
              mes3.add(filtro[i].valorPedido!);
              frete3.add(filtro[i].frete!);
              custo3.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 4:
            {
              mes4.add(filtro[i].valorPedido!);
              frete4.add(filtro[i].frete!);
              custo4.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 5:
            {
              mes5.add(filtro[i].valorPedido!);
              frete5.add(filtro[i].frete!);
              custo5.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 6:
            {
              mes6.add(filtro[i].valorPedido!);
              frete6.add(filtro[i].frete!);
              custo6.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 7:
            {
              mes7.add(filtro[i].valorPedido!);
              frete7.add(filtro[i].frete!);
              custo7.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 8:
            {
              mes8.add(filtro[i].valorPedido!);
              frete8.add(filtro[i].frete!);
              custo8.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 9:
            {
              mes9.add(filtro[i].valorPedido!);
              frete9.add(filtro[i].frete!);
              custo9.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 10:
            {
              mes10.add(filtro[i].valorPedido!);
              frete10.add(filtro[i].frete!);
              custo10.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 11:
            {
              mes11.add(filtro[i].valorPedido!);
              frete11.add(filtro[i].frete!);
              custo11.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 12:
            {
              mes12.add(filtro[i].valorPedido!);
              frete12.add(filtro[i].frete!);
              custo12.add(filtro[i].valorCusto!);
              i++;
            }
            break;
        }
      } else {
        i++;
      }
    }
    state = ViewState(
      mes1: mes1,
      mes2: mes2,
      mes3: mes3,
      mes4: mes4,
      mes5: mes5,
      mes6: mes6,
      mes7: mes7,
      mes8: mes8,
      mes9: mes9,
      mes10: mes10,
      mes11: mes11,
      mes12: mes12,
      frete1: frete1,
      frete2: frete2,
      frete3: frete3,
      frete4: frete4,
      frete5: frete5,
      frete6: frete6,
      frete7: frete7,
      frete8: frete8,
      frete9: frete9,
      frete10: frete10,
      frete11: frete11,
      frete12: frete12,
      custo1: custo1,
      custo2: custo2,
      custo3: custo3,
      custo4: custo4,
      custo5: custo5,
      custo6: custo6,
      custo7: custo7,
      custo8: custo8,
      custo9: custo9,
      custo10: custo10,
      custo11: custo11,
      custo12: custo12,
      empresas: state.empresas,
      sales: state.sales,
      check: state.check,
      filtered: state.filtered,
      isChecked: state.isChecked,
      count: state.count,
    );
  }
  total() {
    var list = [
      state.mes1!.sum,
      state.mes2!.sum,
      state.mes3!.sum,
      state.mes4!.sum,
      state.mes5!.sum,
      state.mes6!.sum,
      state.mes7!.sum,
      state.mes8!.sum,
      state.mes9!.sum,
      state.mes10!.sum,
      state.mes11!.sum,
      state.mes12!.sum,
    ];
    var listFrete = [
      state.frete1!.sum,
      state.frete2!.sum,
      state.frete3!.sum,
      state.frete4!.sum,
      state.frete5!.sum,
      state.frete6!.sum,
      state.frete7!.sum,
      state.frete8!.sum,
      state.frete9!.sum,
      state.frete10!.sum,
      state.frete11!.sum,
      state.frete12!.sum,
    ];
    var listCusto = [
      state.custo1!.sum,
      state.custo2!.sum,
      state.custo3!.sum,
      state.custo4!.sum,
      state.custo5!.sum,
      state.custo6!.sum,
      state.custo7!.sum,
      state.custo8!.sum,
      state.custo9!.sum,
      state.custo10!.sum,
      state.custo11!.sum,
      state.custo12!.sum,
    ];
    for (var i = 0; i < list.length;) {
      if (list[i] == 0) {
        list.remove(list[i]);
        i++;
      } else {
        i++;
      }
    }
    for (var i = 0; i < listFrete.length;) {
      if (listFrete[i] == 0) {
        listFrete.remove(listFrete[i]);
        i++;
      } else {
        i++;
      }
    }
    for (var i = 0; i < listCusto.length;) {
      if (listCusto[i] == 0) {
        listCusto.remove(listCusto[i]);
        i++;
      } else {
        i++;
      }
    }

    state = ViewState(
        mes1: state.mes1,
        mes2: state.mes2,
        mes3: state.mes3,
        mes4: state.mes4,
        mes5: state.mes5,
        mes6: state.mes6,
        mes7: state.mes7,
        mes8: state.mes8,
        mes9: state.mes9,
        mes10: state.mes10,
        mes11: state.mes11,
        mes12: state.mes12,
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        filtered: state.filtered,
        isChecked: state.isChecked,
        rest: list,
        count: state.count,
    restFrete: listFrete,
    restCusto : listCusto);
  }
}
