import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import '../../../../core/global_variables.dart';
import '../models/devolution_model.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Devolution>? devolutions;
  List<int>? empresas = [];
  List<Devolution>? filtered;
  DateTime? initialDate;
  DateTime? endDate;
  int? count;
  List<num>? rest;
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
  List<num>? custo1;
  List<num>? custo2;
  List<num>?custo3;
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
      {this.devolutions,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate,
        this.count,
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
        this.restCusto,
        this.rest,});
}

class DevolutionController extends StateNotifier<ViewState> {
  DevolutionController([ViewState? state]) : super(ViewState());

  Variables variables = Variables();

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
        endDate: state.endDate,count: state.count);
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
        endDate: state.endDate,
        count: state.count);
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
        initialDate: state.initialDate,
        count: state.count);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        devolutions: state.devolutions,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate,count: state.count);
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
            devolutions: state.devolutions,
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
            devolutions: state.devolutions,
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
            devolutions: state.devolutions,
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
            devolutions: state.devolutions,
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
            devolutions: state.devolutions,
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
    List<Devolution>? filtro = filter();
    for (var i = 0; i < filtro!.length;) {
      if (filtro[i].dataLancamento != null) {
        DateTime ola = DateTime.parse((filtro[i].dataLancamento!));
        //colcar na lista do mes certo
        switch (ola.month) {
          case 1:
            {
              mes1.add(filtro[i].valor!);
              custo1.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 2:
            {
              mes2.add(filtro[i].valor!);
              custo2.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 3:
            {
              mes3.add(filtro[i].valor!);
              custo3.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 4:
            {
              mes4.add(filtro[i].valor!);
              custo4.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 5:
            {
              mes5.add(filtro[i].valor!);
              custo5.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 6:
            {
              mes6.add(filtro[i].valor!);
              custo6.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 7:
            {
              mes7.add(filtro[i].valor!);
              custo7.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 8:
            {
              mes8.add(filtro[i].valor!);
              custo8.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 9:
            {
              mes9.add(filtro[i].valor!);
              custo9.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 10:
            {
              mes10.add(filtro[i].valor!);
              custo10.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 11:
            {
              mes11.add(filtro[i].valor!);
              custo11.add(filtro[i].valorCusto!);
              i++;
            }
            break;
          case 12:
            {
              mes12.add(filtro[i].valor!);
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
      devolutions: state.devolutions,
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
        devolutions: state.devolutions,
        check: state.check,
        filtered: state.filtered,
        isChecked: state.isChecked,
        rest: list,
        restCusto: listCusto,
        count: state.count);
  }
}

