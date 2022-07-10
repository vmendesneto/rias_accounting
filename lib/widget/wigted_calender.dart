import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rias_accounting/report/receive/screen/receive_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../report/receive/providers/receive_provider.dart';
import '../report/report_screen/reportScreen.dart';

class MyCalender extends ConsumerStatefulWidget {
  final String task;



  MyCalender({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  ConsumerState createState() => MyCalenderState();
}

class MyCalenderState extends ConsumerState<MyCalender> {
  String _range = '${DateFormat('dd/MM/yyyy').format(
    DateTime.now().subtract(const Duration(days: 4)),
  )} -'
      ' ${DateFormat('dd/MM/yyyy').format(DateTime.now().add(const Duration(days: 0)))}';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final stateReceive = ref.watch(receiveProvider);
    final receive = ref.read(receiveProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.task,
            style: TextStyle(fontSize: _width * 0.1),
          )),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: _height * 0.009),
          Text('Selected range: $_range'),
          SizedBox(height: _height * 0.005),
          Text("Filtrar : ", style: TextStyle(fontSize: _width * 0.1)),
          SizedBox(height: _height * 0.005),
          Container(
              color: const Color(0xffDCDCDC),
              height: _height * 0.25,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  SfDateRangePicker(
                    todayHighlightColor: Colors.green,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 0))),
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 40.0,
            child: listEmpresas(stateReceive, receive),
          ),
          ElevatedButton(
            onPressed: () {
              //ALGUEM VAI RECEBER O _RANGE
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>ReceiveScreen()));
            },
            child: const Text('Selecionar'),
          ),
        ]));
  }
}

Widget listEmpresas(stateReceive, receive) {
  return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stateReceive.empresas.length,
          itemBuilder: (context, index) {
            return Container(
                width: 60,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        stateReceive.empresas[index].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      Checkbox(
                          value: stateReceive.check.contains(stateReceive.empresas[index]) ? true: false,
                          onChanged: (val) {
                            if (val == true) {
                              receive.trueCheck(stateReceive.empresas[index]);
                            }else {
                              receive.falseCheck(stateReceive.empresas[index]);
                            }
                          })
                    ]));
          });
}

