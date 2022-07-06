import 'package:flutter/material.dart';

class ReportAccountScreen extends StatelessWidget {
  const ReportAccountScreen({Key? key}) : super(key: key);

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
                    onTap: () {},
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'Fluxo',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
                GestureDetector(
                    onTap: () {},
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'DRE',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
                GestureDetector(
                    onTap: () {},
                    child: Card(
                        elevation: 10.0,
                        child: Container(
                          width: _widht,
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.all(20.0),
                          child: const Center(
                              child: Text(
                            'CMV',
                            style: TextStyle(fontSize: 40),
                          )),
                        ))),
              ],
            ),
          )),
    );
  }
}
