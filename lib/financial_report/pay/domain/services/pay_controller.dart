import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:collection/collection.dart';
import '../../../../core/global_variables.dart';
import '../models/pay_model.dart';

class PayState {
  bool isChecked;
  List<int>? check;
  List<Pay>? pays;
  List<int>? empresas = [];
  List<Pay>? filtered;
  DateTime? initialDate;
  DateTime? endDate;
  int? count;
  List<String>? meses =[];
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
  List<num>? rest;

  PayState(
      {this.pays,
      this.check,
      this.isChecked = false,
      this.empresas,
      this.filtered,
      this.initialDate,
      this.endDate,
      this.count, this.meses,
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
        this.mes12,this.rest});
}

class PayController extends StateNotifier<PayState> {
  PayController([PayState? state]) : super(PayState());

  Variables variables = Variables();
  List<String> lista =[];

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = PayState(initialDate: now, endDate: end);
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
    state = PayState(
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
              filters.add(dado[i]);
            } else {}
          }
        }
      }
    }
    //ORDENANDO POR DATA DE PG
    filters.sort((a, b) => a.datapagamento!.compareTo(b.datapagamento!));
    state = PayState(
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

    state = PayState(
        empresas: state.empresas,
        pays: state.pays,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate,
        count: state.count,
        meses: state.meses);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = PayState(
        empresas: state.empresas,
        pays: state.pays,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate, count: state.count,
        meses: state.meses);
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      var now = args.value.startDate;
      var end = args.value.endDate ?? args.value.startDate;
      state = PayState(
          initialDate: now,
          endDate: end,
          empresas: state.empresas,
          pays: state.pays,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }
  void onSelection(int option) {
    List<String> mesesOpt = [];
    switch (option) {
      case 1:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 1, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          mesesOpt.add((variables.today.month - 1).toString());


          state = PayState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            pays: state.pays,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 1,
            meses: mesesOpt,
          );
        }
        break;
      case 2:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 3, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          mesesOpt.add((variables.today.month - 1).toString());
          mesesOpt.add((variables.today.month - 2).toString());
          mesesOpt.add((variables.today.month - 3).toString());
          state = PayState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            pays: state.pays,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 3,
            meses: mesesOpt,
          );
        }
        break;
      case 3:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 6, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          mesesOpt.add((variables.today.month - 1).toString());
          mesesOpt.add((variables.today.month - 2).toString());
          mesesOpt.add((variables.today.month - 3).toString());
          mesesOpt.add((variables.today.month - 4).toString());
          mesesOpt.add((variables.today.month - 5).toString());
          mesesOpt.add((variables.today.month - 6).toString());

          state = PayState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            pays: state.pays,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 6,
            meses: mesesOpt,
          );
        }
        break;
      case 4:
        {
          var dateInitial =
          DateTime(variables.today.year, variables.today.month - 12, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          mesesOpt.add((variables.today.month - 1).toString());
          mesesOpt.add((variables.today.month - 2).toString());
          mesesOpt.add((variables.today.month - 3).toString());
          mesesOpt.add((variables.today.month - 4).toString());
          mesesOpt.add((variables.today.month - 5).toString());
          mesesOpt.add((variables.today.month - 6).toString());
          mesesOpt.add((variables.today.month - 7).toString());
          mesesOpt.add((variables.today.month - 8).toString());
          mesesOpt.add((variables.today.month - 9).toString());
          mesesOpt.add((variables.today.month - 10).toString());
          mesesOpt.add((variables.today.month - 11).toString());
          mesesOpt.add((variables.today.month - 12).toString());

          state = PayState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            pays: state.pays,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: 12,
            meses: mesesOpt,
          );
        }
        break;
      case 5:
        {
          var dateInitial = DateTime(variables.today.year, 01, 01);
          var dateFinal =
          DateTime(variables.today.year, variables.today.month, 01);
          state = PayState(
            initialDate: dateInitial,
            endDate: dateFinal,
            empresas: state.empresas,
            pays: state.pays,
            check: state.check,
            filtered: state.filtered,
            isChecked: state.isChecked,
            count: variables.today.month - 1,
          );
        }
        break;
    }
  }
  separateMonth(int conta) {
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
    List<Pay>? filtro = filter();
    for (var i = 0; i < filtro!.length;) {
      if (filtro[i].datapagamento != null) {
        DateTime ola = DateTime.parse((filtro[i].datapagamento!));
        if (filtro[i].codConta == conta) {
          //colcar na lista do mes certo
          switch (ola.month) {
            case 1:
              {
                mes1.add(filtro[i].total!);
                lista.add('mes1');
                i++;
              }
              break;
            case 2:
              {
                mes2.add(filtro[i].total!);
                lista.add('mes2');
                i++;
              }
              break;
            case 3:
              {
                mes3.add(filtro[i].total!);
                lista.add('mes3');
                i++;
              }
              break;
            case 4:
              {
                mes4.add(filtro[i].total!);
                lista.add('mes4');
                i++;
              }
              break;
            case 5:
              {
                mes5.add(filtro[i].total!);
                lista.add('mes5');
                i++;
              }
              break;
            case 6:
              {
                mes6.add(filtro[i].total!);
                lista.add('mes6');
                i++;
              }
              break;
            case 7:
              {
                mes7.add(filtro[i].total!);
                lista.add('mes7');
                i++;
              }
              break;
            case 8:
              {
                mes8.add(filtro[i].total!);
                lista.add('mes8');
                i++;
              }
              break;
            case 9:
              {
                mes9.add(filtro[i].total!);
                lista.add('mes9');
                i++;
              }
              break;
            case 10:
              {
                mes10.add(filtro[i].total!);
                lista.add('mes10');
                i++;
              }
              break;
            case 11:
              {
                mes11.add(filtro[i].total!);
                lista.add('mes11');
                i++;
              }
              break;
            case 12:
              {
                mes12.add(filtro[i].total!);
                lista.add('mes12');
                i++;
              }
              break;
          }
        } else {
          i++;
        }
      }else{
        i++;
      }
    }
    state = PayState(
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
      empresas: state.empresas,
      pays: state.pays,
      check: state.check,
      filtered: state.filtered,
      isChecked: state.isChecked,
      count: state.count,
      meses: state.meses,
    );
  }
  total() {
    List<num> list = [];
    var valor = lista.length;
    for (var i = 0; i < valor; i++) {
      if (lista.contains('mes1')) {
        list.add(state.mes1!.sum);
        lista.removeWhere((element) => element == 'mes1');
      } else if (lista.contains('mes2')) {
        list.add(state.mes2!.sum);
        lista.removeWhere((element) => element == 'mes2');
      } else if (lista.contains('mes3')) {
        list.add(state.mes3!.sum);
        lista.removeWhere((element) => element == 'mes3');
      } else if (lista.contains('mes4')) {
        list.add(state.mes4!.sum);
        lista.removeWhere((element) => element == 'mes4');
      } else if (lista.contains('mes5')) {
        list.add(state.mes5!.sum);
        lista.removeWhere((element) => element == 'mes5');
      } else if (lista.contains('mes6')) {
        list.add(state.mes6!.sum);
        lista.removeWhere((element) => element == 'mes6');
      } else if (lista.contains('mes7')) {
        list.add(state.mes7!.sum);
        lista.removeWhere((element) => element == 'mes7');
      } else if (lista.contains('mes8')) {
        list.add(state.mes8!.sum);
        lista.removeWhere((element) => element == 'mes8');
      } else if (lista.contains('mes9')) {
        list.add(state.mes9!.sum);
        lista.removeWhere((element) => element == 'mes9');
      } else if (lista.contains('mes10')) {
        list.add(state.mes10!.sum);
        lista.removeWhere((element) => element == 'mes10');
      } else if (lista.contains('mes11')) {
        list.add(state.mes11!.sum);
        lista.removeWhere((element) => element == 'mes11');
      } else {
        list.add(state.mes12!.sum);
        lista.removeWhere((element) => element == 'mes12');
      }
    }

    state = PayState(
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
      pays: state.pays,
      check: state.check,
      filtered: state.filtered,
      isChecked: state.isChecked,
      rest: list,
      count: state.count,
      meses: state.meses,
    );

  }

}
