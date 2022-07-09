import 'package:flutter/material.dart';

import '../../widget/wigted_calender.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int visivel = 0;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Material(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: visivel == 1 ? (_height * 0.32) : (_height * 0.105),
        alignment: Alignment.center,
        width: _width * 0.8,
        color: const Color(0xffDCDCDC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    visivel != 1 ? visivel = 1 : visivel = 0;
                  });
                  print(visivel);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: _height * 0.1,
                    width: _width * 0.78,
                    child: Text(
                      "Relatórios Financeiros",
                      style: TextStyle(color: Colors.white, fontSize: _width * 0.08, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    color: const Color(0xff000080))),
            visivel == 1
                ? test(context, "Recebimentos", "Pagamentos", 'Devolução', 0xff6495ED)
                : Container()
          ],
        ),
      ),
      Container(
        height: visivel == 2 ? (_height * 0.35) : (_height * 0.105),
        alignment: Alignment.center,
        width: _width * 0.8,
        color: const Color(0xffDCDCDC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    visivel != 2 ? visivel = 2 : visivel = 0;
                  });
                  print(visivel);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: _height * 0.1,
                    width: _width * 0.78,
                    child: Text(
                      "Relatórios Contábeis",
                      style: TextStyle(color: Colors.white, fontSize: _width * 0.08, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    color: const Color(0xff8B008B))),
            visivel == 2
                ? test(context, "Fluxo", "D.R.E", 'C.M.V', 0xffEE82EE)
                : Container()
          ],
        ),
      ),
    ])));
  }
}

Widget test(BuildContext context, String a, String b, String c, int color) {
  final _width = MediaQuery.of(context).size.width;
  final _height = MediaQuery.of(context).size.height;

  String _task = '';

  return Column(children: [
    SizedBox(height: _height * 0.02),
    GestureDetector(
      onTap: () {
        _task = a;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyCalender(task: _task)));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          a,style:  TextStyle(color: Colors.white, fontSize: _width * 0.06, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        color: Color(color),
        height: _height * 0.06,
        width: _width * 0.78,
      ),
    ),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
           _task = b;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyCalender(task: _task)));
        },
        child: Container(
            alignment: Alignment.center,
            color: Color(color),
            height: _height * 0.06,
            width: _width * 0.78,
            child: Text(
              b,style: TextStyle(color: Colors.white, fontSize: _width * 0.06, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ))),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
          _task = c;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyCalender(task: _task)));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            c,style: TextStyle(color: Colors.white, fontSize: _width * 0.06, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          color: Color(color),
          height: _height * 0.06,
          width: _width * 0.78,
        )),
  ]);
}
