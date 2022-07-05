import 'package:flutter/material.dart';

import '../faturamentos/faturamento.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final _widht = MediaQuery.of(context).size.width;


    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Rais-Accounting")),
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FaturamentoView()));
                    },
                      child: Card(
                          elevation: 10.0,
                          child: Container(
                            width: _widht,
                            color: Colors.blueAccent,
                            padding: const EdgeInsets.all(20.0),
                            child: const Center(child:  Text(
                              'Faturamentos',
                              style: TextStyle(fontSize: 40),
                            )),
                          )))
                ],
              ),
            )));
  }
}
