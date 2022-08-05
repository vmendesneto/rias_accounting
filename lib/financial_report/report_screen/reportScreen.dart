import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/widget/widget_accounting_filter.dart';

import '../../widget/wigted_calender.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => ReportScreenState();
}

class ReportScreenState extends ConsumerState<ReportScreen> {
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
        height: visivel == 1 ? (_height * 0.45) : (_height * 0.105),
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
                },
                child: Container(
                    alignment: Alignment.center,
                    height: _height * 0.1,
                    width: _width * 0.78,
                    child: Text(
                      "Relatórios Financeiros",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: _width * 0.08,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    color: const Color(0xff000080))),
            visivel == 1
                ? expandFinanc(context, "Recebimentos", "Pagamentos",
                    'Devolução', 'Folha de Pagamento',"Vendas", 0xff6495ED)
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: _width * 0.08,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    color: const Color(0xff8B008B))),
            visivel == 2
                ? expandCont(context, "Faturamento", "D.R.E", 'C.M.V', 0xffEE82EE)
                : Container()
          ],
        ),
      ),
    ])));
  }
}

Widget expandFinanc(
    BuildContext context, String a, String b, String c, String d,String e, int color) {
  final _width = MediaQuery.of(context).size.width;
  final _height = MediaQuery.of(context).size.height;

  String _task = '';

  return Column(children: [
    SizedBox(height: _height * 0.02),
    GestureDetector(
      onTap: () {
        _task = a;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyCalender(
                  title: _task,
                  select: 0,
                )));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          a,
          style: TextStyle(
              color: Colors.white,
              fontSize: _width * 0.06,
              fontWeight: FontWeight.w400),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCalender(title: _task, select: 1)));
        },
        child: Container(
            alignment: Alignment.center,
            color: Color(color),
            height: _height * 0.06,
            width: _width * 0.78,
            child: Text(
              b,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: _width * 0.06,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ))),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
          _task = c;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCalender(title: _task, select: 2)));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            c,
            style: TextStyle(
                color: Colors.white,
                fontSize: _width * 0.06,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          color: Color(color),
          height: _height * 0.06,
          width: _width * 0.78,
        )),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
          _task = d;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCalender(title: _task, select: 3)));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            d,
            style: TextStyle(
                color: Colors.white,
                fontSize: _width * 0.06,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          color: Color(color),
          height: _height * 0.06,
          width: _width * 0.78,
        )),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
          _task = e;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCalender(title: _task, select: 5)));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            e,
            style: TextStyle(
                color: Colors.white,
                fontSize: _width * 0.06,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          color: Color(color),
          height: _height * 0.06,
          width: _width * 0.78,
        )),
  ]);
}
Widget expandCont(
    BuildContext context, String a, String b, String c, int color) {
  final _width = MediaQuery.of(context).size.width;
  final _height = MediaQuery.of(context).size.height;

  String _task = '';

  return Column(children: [
    SizedBox(height: _height * 0.02),
    GestureDetector(
      onTap: () {
        _task = a;
         Navigator.of(context).push(MaterialPageRoute(
             builder: (context) => FilterAccounting(
             )));
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          a,
          style: TextStyle(
              color: Colors.white,
              fontSize: _width * 0.06,
              fontWeight: FontWeight.w400),
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
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => MyCalender(title: _task, select: 1)));
        },
        child: Container(
            alignment: Alignment.center,
            color: Color(color),
            height: _height * 0.06,
            width: _width * 0.78,
            child: Text(
              b,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: _width * 0.06,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ))),
    SizedBox(height: _height * 0.005),
    GestureDetector(
        onTap: () {
          _task = c;
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => MyCalender(title: _task, select: 2)));
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            c,
            style: TextStyle(
                color: Colors.white,
                fontSize: _width * 0.06,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          color: Color(color),
          height: _height * 0.06,
          width: _width * 0.78,
        )),
  ]);
}
