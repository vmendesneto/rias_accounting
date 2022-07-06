import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyCalender extends StatefulWidget {
  final String task;

  const MyCalender({Key? key, required this.task}) : super(key: key);

  @override
  MyCalenderState createState() => MyCalenderState();
}

class MyCalenderState extends State<MyCalender> {
  String _range = '${DateFormat('dd/MM/yyyy').format(
    DateTime.now().subtract(const Duration(days: 4)),
  )} -'
      ' ${DateFormat('dd/MM/yyyy').format(DateTime.now().add(const Duration(days: 0)))}';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const SizedBox(height: 30),
      Text('Selected range: $_range'),
      const SizedBox(height: 10),
      Text(widget.task),
      const SizedBox(height: 15),
      const Text("Filtrar Periodo :"),
      const SizedBox(height: 15),
      Container(
          color: Colors.amberAccent,
          height: 200,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 0))),
              ),
            ],
          )),
      ElevatedButton(
        onPressed: () {
          //ALGUEM VAI RECEBER O _RANGE
        },
        child: const Text('Selecionar'),
      ),
    ]));
  }
}
