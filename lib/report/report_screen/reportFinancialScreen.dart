import 'package:flutter/material.dart';

import '../../wigted_calender.dart';

class ReportFinancialScreen extends StatelessWidget {
  const ReportFinancialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _widht = MediaQuery.of(context).size.width;

    return Material(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      String _task = "Recebimentos";
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCalender(task: _task)));
                    },
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'Recebimentos',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
                GestureDetector(
                    onTap: () {
                    String _task = "Pagamentos";
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCalender(task: _task)));
                    },
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'Pagamentos',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
                GestureDetector(
                    onTap: () {
                      String _task = "Devoluções";
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyCalender(task: _task)));

                    },
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'Devoluções',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
              ],
            ),
          )),
    );
  }
}
