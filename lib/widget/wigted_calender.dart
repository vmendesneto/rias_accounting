import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/report/%20devolution/providers/devolution_provider.dart';
import 'package:rias_accounting/report/inventory/screen/inventory_sreen.dart';
import 'package:rias_accounting/report/payroll/providers/payroll_provider.dart';
import 'package:rias_accounting/report/payroll/screen/payroll_screen.dart';
import 'package:rias_accounting/report/receive/screen/receive_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../report/ devolution/screen/devolution_screen.dart';
import '../report/inventory/provider/inventory_provider.dart';
import '../report/pay/providers/pay_provider.dart';
import '../report/pay/screen/pay_screen.dart';
import '../report/receive/providers/receive_provider.dart';
import '../report/sales/provider/sale_provider.dart';
import '../report/sales/screen/sale_screen.dart';

class MyCalender extends ConsumerStatefulWidget {
  final String title;
  final int select;

  MyCalender({Key? key, required this.title, required this.select})
      : super(key: key);

  @override
  ConsumerState createState() => MyCalenderState();
}

class MyCalenderState extends ConsumerState<MyCalender> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final stateReceive = ref.watch(receiveProvider);
    final receive = ref.read(receiveProvider.notifier);
    final statePay = ref.watch(payProvider);
    final pay = ref.read(payProvider.notifier);
    final stateDev = ref.watch(devolutionProvider);
    final dev = ref.read(devolutionProvider.notifier);
    final statePayroll = ref.watch(payrollProvider);
    final payroll = ref.watch(payrollProvider.notifier);
    final stateInventory = ref.watch(inventoryProvider);
    final inventory = ref.watch(inventoryProvider.notifier);
    final stateSale = ref.watch(saleProvider);
    final sale = ref.watch(saleProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.title,
            //style: TextStyle(fontSize: _width * 0.1),
          )),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: _height * 0.009),
          // Text('Selected range: ${stateReceive.initialDate.toString()} - ${stateReceive.endDate.toString()}'),
          SizedBox(height: _height * 0.005),
          Text("Filtrar : ", style: TextStyle(fontSize: _width * 0.1)),
          SizedBox(height: _height * 0.005),
          Container(
              color: const Color(0xffDCDCDC),
              height: _height * 0.25,
              width: double.infinity,
              child: onSelection(pay, receive, dev, widget, payroll, inventory, sale)),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 40.0,
            child: Empresas(
                stateReceive, receive, statePay, pay, stateDev, dev, widget,statePayroll, payroll, stateInventory, inventory, stateSale, sale),
          ),
          ElevatedButton(
            onPressed: () {
              //ALGUEM VAI RECEBER O _RANGE
              switch (widget.select) {
                case (0):
                  receiveOpt(context, ref);
                  break;
                case (1):
                  payOpt(context, ref);
                  break;
                case (2):
                  devOpt(context, ref);
                  break;
                case (3):
                  payrollOpt(context, ref);
                  break;
                case (4):
                  inventoryOpt(context, ref);
                  break;
                case (5):
                  saleOpt(context, ref);
                  break;
              }
              // if (widget.select == 0) {
              //   receiveOpt(context, ref);
              // }
              // if (widget.select == 1) {
              //   payOpt(context, ref);
              // }
              // if (widget.select == 2) {
              //   devOpt(context, ref);
              // }
              // if(widget.select == 3){
              //   payrollOpt(context, ref);
              // }
              // if(widget.select == 4){
              //   inventoryOpt(context, ref);
              // }
            },
            child: const Text('Selecionar'),
          ),
        ]));
  }
}

payOpt(BuildContext context, WidgetRef ref) {
  final pay = ref.read(payProvider.notifier);
  pay.filter();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PayScreen(title: "Controle de Lançamentos")));
}

receiveOpt(BuildContext context, WidgetRef ref) {
  final receive = ref.read(receiveProvider.notifier);
  receive.filter();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ReceiveScreen(title: "Controle de Recebimentos")));
}

devOpt(BuildContext context, WidgetRef ref) {
  final dev = ref.read(devolutionProvider.notifier);
  dev.filter();
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DevScreen(title: "Devoluções")));
}
payrollOpt(BuildContext context, WidgetRef ref){
  final payroll = ref.read(payrollProvider.notifier);
  payroll.filter();
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PayRollScreen(title: 'Folha de Pagamento')));
}
inventoryOpt(BuildContext context, WidgetRef ref) {
  final inventory = ref.read(inventoryProvider.notifier);
  inventory.filter();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InventoryScreen(title: 'Estoque')));
}
saleOpt(BuildContext context, WidgetRef ref){
  final sale = ref.read(saleProvider.notifier);
  sale.filter();
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SaleScreen(title: 'Vendas')));
}

Widget onSelection(pay, receive, dev, widget, payroll, inventory, sale) {
  if (widget.select == 0) {
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: receive.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  if (widget.select == 1) {
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: pay.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  if (widget.select == 2) {
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: dev.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  if(widget.select == 3){
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: payroll.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  if(widget.select == 4){
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: inventory.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  if(widget.select == 5){
    return Stack(
      children: <Widget>[
        SfDateRangePicker(
          todayHighlightColor: Colors.green,
          onSelectionChanged: sale.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 0))),
        ),
      ],
    );
  }
  return Container();
}

Widget Empresas(stateReceive, receive, statePay, pay, stateDev, dev, widget, statePayroll, payroll, stateInventory, inventory, stateSale, sale) {
  if (widget.select == 0) {
    return listEmpresasReceive(stateReceive, receive);
  }
  if (widget.select == 1) {
    return listEmpresasPay(statePay, pay);
  }
  if (widget.select == 2) {
    return listEmpresasDev(stateDev, dev);
  }
  if(widget.select == 3){
    return listEmpresasPayRoll(statePayroll, payroll);
  }
  if(widget.select == 4){
    return listEmpresasInventory(stateInventory, inventory);
  }
  if(widget.select == 5){
    return listEmpresasSale(stateSale, sale);
  }
  return Container();
}

Widget listEmpresasReceive(stateReceive, receive) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stateReceive.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                stateReceive.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value:
                      stateReceive.check.contains(stateReceive.empresas[index])
                          ? true
                          : false,
                  onChanged: (val) {
                    if (val == true) {
                      receive.trueCheck(stateReceive.empresas[index]);
                    } else {
                      receive.falseCheck(stateReceive.empresas[index]);
                    }
                  })
            ]));
      });
}

Widget listEmpresasPay(statePay, pay) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: statePay.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                statePay.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: statePay.check.contains(statePay.empresas[index])
                      ? true
                      : false,
                  onChanged: (val) {
                    if (val == true) {
                      pay.trueCheck(statePay.empresas[index]);
                    } else {
                      pay.falseCheck(statePay.empresas[index]);
                    }
                  })
            ]));
      });
}

Widget listEmpresasDev(stateDev, dev) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stateDev.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                stateDev.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: stateDev.check.contains(stateDev.empresas[index])
                      ? true
                      : false,
                  onChanged: (val) {
                    if (val == true) {
                      dev.trueCheck(stateDev.empresas[index]);
                    } else {
                      dev.falseCheck(stateDev.empresas[index]);
                    }
                  })
            ]));
      });
}
Widget listEmpresasPayRoll(statePayroll, payroll) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: statePayroll.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                statePayroll.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: statePayroll.check.contains(statePayroll.empresas[index])
                      ? true
                      : false,
                  onChanged: (val) {
                    if (val == true) {
                      payroll.trueCheck(statePayroll.empresas[index]);
                    } else {
                      payroll.falseCheck(statePayroll.empresas[index]);
                    }
                  })
            ]));
      });
}
Widget listEmpresasInventory(stateInventory, inventory) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stateInventory.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                stateInventory.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: stateInventory.check.contains(stateInventory.empresas[index])
                      ? true
                      : false,
                  onChanged: (val) {
                    if (val == true) {
                      inventory.trueCheck(stateInventory.empresas[index]);
                    } else {
                      inventory.falseCheck(stateInventory.empresas[index]);
                    }
                  })
            ]));
      });
}
Widget listEmpresasSale(stateSale, sale) {
  return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stateSale.empresas.length,
      itemBuilder: (context, index) {
        return Container(
            width: 70,
            child:
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                stateSale.empresas[index].toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: stateSale.check.contains(stateSale.empresas[index])
                      ? true
                      : false,
                  onChanged: (val) {
                    if (val == true) {
                      sale.trueCheck(stateSale.empresas[index]);
                    } else {
                     sale.falseCheck(stateSale.empresas[index]);
                    }
                  })
            ]));
      });
}