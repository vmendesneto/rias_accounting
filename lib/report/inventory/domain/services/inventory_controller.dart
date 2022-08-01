import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/report/inventory/domain/models/inventory_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ViewState {
  bool isChecked;
  List<int>? check;
  List<Inventory>? inventorys;
  List<int>? empresas = [];
  List<Inventory>? filtered;
  DateTime? initialDate;
  DateTime? endDate;

  ViewState(
      {this.inventorys,
        this.check,
        this.isChecked = false,
        this.empresas,
        this.filtered,
        this.initialDate,
        this.endDate});
}

class InventoryController extends StateNotifier<ViewState> {
  InventoryController([ViewState? state]) : super(ViewState());

  void dateInitial() {
    var now = DateTime.now().subtract(const Duration(days: 4));
    var end = DateTime.now().add(const Duration(days: 0));
    state = ViewState(initialDate: now, endDate: end);
  }

  Future<List<Inventory>> emp() async {
    List<int> lista = [];
    List<Inventory> inventorys = await fetchInventory();
    for (var i = 0; i < inventorys.length;) {
      if (lista.isEmpty) {
        lista.add(inventorys[i].empresa!);
        lista.sort();
        i++;
      } else {
        if (lista.contains(inventorys[i].empresa!)) {
          i++;
        } else {
          lista.add(inventorys[i].empresa!);
          lista.sort();
          i++;
        }
      }
    }
    state.check ??= [];
    state.filtered ??= [];
    state = ViewState(
        empresas: lista,
        inventorys: inventorys,
        isChecked: state.isChecked,
        check: state.check,
        filtered: state.filtered,
        initialDate: state.initialDate,
        endDate: state.endDate);
    return inventorys;
  }

  List<Inventory>? filter() {
    List<Inventory>? a = state.inventorys;
    var dado;
    var checks = state.check;
    var check;
    var dateInitial = state.initialDate;
    var dateI = dateInitial!.subtract(const Duration(days: 1));
    var dateFinal = state.endDate;
    var dateF = dateFinal!.add(const Duration(days: 1));
    List<Inventory>? filters = state.filtered;
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
        inventorys: state.inventorys,
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
        inventorys: state.inventorys,
        check: state.check,
        endDate: state.endDate,
        filtered: state.filtered,
        initialDate: state.initialDate);
  }

  falseCheck(int emp) {
    state.check!.remove(emp);
    state = ViewState(
        empresas: state.empresas,
        inventorys: state.inventorys,
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
          inventorys: state.inventorys,
          check: state.check,
          filtered: state.filtered,
          isChecked: state.isChecked);
    }
  }
}
