import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/core/global_variables.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import '../models/sales_model.dart';

class ViewStates {
  bool isChecked;
  List<int>? check;
  List<Sale>? sales;
  List<int>? empresas = [];
  List<Sale>? filtered;
  DateTime? initialDate;
  DateTime? endDate;
  int? count;
  List<String>? meses =[];
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

  ViewStates(
      {this.sales,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate,
      this.count,
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
      this.restCusto,
      this.meses});
}

class SaleController extends StateNotifier<ViewStates> {
  SaleController([ViewStates? state]) : super(ViewStates());

  Variables variables = Variables();

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewStates(initialDate: now, endDate: end);
  }

List<String> lista =[];

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
    state = ViewStates(
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
    state = ViewStates(
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        filtered: filters,
        initialDate: state.initialDate,
        endDate: state.endDate,
        count: state.count,
        meses: state.meses);
    return filters;
  }

  trueCheck(int emp) {
    state.check!.add(emp);

    state = ViewStates(
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate,
        count: state.count,
        meses: state.meses);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewStates(
        empresas: state.empresas,
        sales: state.sales,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate,
        count: state.count,
    meses: state.meses);
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      var now = args.value.startDate;
      var end = args.value.endDate ?? args.value.startDate;
      state = ViewStates(
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
          state = ViewStates(
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
          state = ViewStates(
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
          state = ViewStates(
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
          state = ViewStates(
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
          var dateInitial = DateTime(variables.today.year, 01, 01);
          var dateFinal =
              DateTime(variables.today.year, variables.today.month, 01);
          state = ViewStates(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            sales: state.sales,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: variables.today.month - 1,
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
    List<num> custo5 = [];
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
        DateTime ola = DateTime.parse((filtro[i].dataFaturamento!));
        //colcar na lista do mes certo
        switch (ola.month) {
          case 1:
            {
              mes1.add(filtro[i].valorPedido!);
              lista.add('mes1');
              frete1.add(filtro[i].frete!);
              custo1.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 2:
            {
              mes2.add(filtro[i].valorPedido!);
              lista.add('mes2');
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
              lista.add('mes3');
              i++;
            }
            break;
          case 4:
            {
              mes4.add(filtro[i].valorPedido!);
              frete4.add(filtro[i].frete!);
              custo4.add(filtro[i].valorCusto!);
              lista.add('mes4');
              i++;
            }
            break;
          case 5:
            {
              mes5.add(filtro[i].valorPedido!);
              frete5.add(filtro[i].frete!);
              custo5.add(filtro[i].valorCusto!);
              lista.add('mes5');
              i++;
            }
            break;
          case 6:
            {
              mes6.add(filtro[i].valorPedido!);
              frete6.add(filtro[i].frete!);
              custo6.add(filtro[i].valorCusto!);
              lista.add('mes6');
              i++;
            }
            break;
          case 7:
            {
              mes7.add(filtro[i].valorPedido!);
              frete7.add(filtro[i].frete!);
              custo7.add(filtro[i].valorCusto!);
              lista.add('mes7');
              i++;
            }
            break;
          case 8:
            {
              mes8.add(filtro[i].valorPedido!);
              frete8.add(filtro[i].frete!);
              custo8.add(filtro[i].valorCusto!);
              lista.add('mes8');
              i++;
            }
            break;
          case 9:
            {
              mes9.add(filtro[i].valorPedido!);
              frete9.add(filtro[i].frete!);
              custo9.add(filtro[i].valorCusto!);
              lista.add('mes9');
              i++;
            }
            break;
          case 10:
            {
              mes10.add(filtro[i].valorPedido!);
              frete10.add(filtro[i].frete!);
              custo10.add(filtro[i].valorCusto!);
              lista.add('mes10');
              i++;
            }
            break;
          case 11:
            {
              mes11.add(filtro[i].valorPedido!);
              frete11.add(filtro[i].frete!);
              custo11.add(filtro[i].valorCusto!);
              lista.add('mes11');
              i++;
            }
            break;
          case 12:
            {
              mes12.add(filtro[i].valorPedido!);
              frete12.add(filtro[i].frete!);
              custo12.add(filtro[i].valorCusto!);
              lista.add('mes12');
              i++;
            }
            break;
        }
      } else {
        i++;
      }
    }
    state = ViewStates(
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
      meses: lista,
    );
  }

  total() {
    List<num> list = [];
    List<num> listFrete = [];
    List<num> listCusto = [];
    var valor = lista.length;
    for (var i = 0; i < valor; i++) {
      if (lista.contains('mes1')) {
        list.add(state.mes1!.sum);
        listFrete.add(state.frete1!.sum);
        listCusto.add(state.custo1!.sum);
        lista.remove('mes1');
      } else if (lista.contains('mes2')) {
        list.add(state.mes2!.sum);
        listFrete.add(state.frete2!.sum);
        listCusto.add(state.custo2!.sum);
        lista.remove('mes2');
      } else if (lista.contains('mes3')) {
        list.add(state.mes3!.sum);
        listFrete.add(state.frete3!.sum);
        listCusto.add(state.custo3!.sum);
        lista.remove('mes3');
      } else if (lista.contains('mes4')) {
        list.add(state.mes4!.sum);
        listFrete.add(state.frete4!.sum);
        listCusto.add(state.custo4!.sum);
        lista.remove('mes4');
      } else if (lista.contains('mes5')) {
        list.add(state.mes5!.sum);
        listFrete.add(state.frete5!.sum);
        listCusto.add(state.custo5!.sum);
        lista.remove('mes5');
      } else if (lista.contains('mes6')) {
        list.add(state.mes6!.sum);
        listFrete.add(state.frete6!.sum);
        listCusto.add(state.custo6!.sum);
        lista.remove('mes6');
      } else if (lista.contains('mes7')) {
        list.add(state.mes7!.sum);
        listFrete.add(state.frete7!.sum);
        listCusto.add(state.custo7!.sum);
        lista.remove('mes7');
      } else if (lista.contains('mes8')) {
        list.add(state.mes8!.sum);
        listFrete.add(state.frete8!.sum);
        listCusto.add(state.custo8!.sum);
        lista.remove('mes8');
      } else if (lista.contains('mes9')) {
        list.add(state.mes9!.sum);
        listFrete.add(state.frete9!.sum);
        listCusto.add(state.custo9!.sum);
        lista.remove('mes9');
      } else if (lista.contains('mes10')) {
        list.add(state.mes10!.sum);
        listFrete.add(state.frete10!.sum);
        listCusto.add(state.custo10!.sum);
        lista.remove('mes10');
      } else if (lista.contains('mes11')) {
        list.add(state.mes11!.sum);
        listFrete.add(state.frete11!.sum);
        listCusto.add(state.custo11!.sum);
        lista.remove('mes11');
      } else {
        list.add(state.mes12!.sum);
        listFrete.add(state.frete12!.sum);
        listCusto.add(state.custo12!.sum);
        lista.remove('mes12');
      }
    }
print('stado de meses : ${state.meses}');
    state = ViewStates(
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
        restCusto: listCusto,
        meses: state.meses);
  }
}
