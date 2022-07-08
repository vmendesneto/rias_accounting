import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rias_accounting/report/receive/domain/models/receive_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyCalender extends StatefulWidget {
  final String task;
  Future<List<Receive>>? receives;

   MyCalender({Key? key, required this.task, this.receives}) : super(key: key);

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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.task,
            style: TextStyle(fontSize: _width * 0.1),
          )),
        ),
        body: Column(children: [
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
          Container(
            color: Colors.red,
            child: FutureBuilder<List<Receive>>(
                future: widget.receives,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Text(snapshot.data![index].empresa.toString());
                        });
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          ElevatedButton(
            onPressed: () {
              //ALGUEM VAI RECEBER O _RANGE
            },
            child: const Text('Selecionar'),
          ),
        ]));
  }
}
