import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/date_text_formatter.dart';
import 'domain/models/payroll_maunal_model.dart';

Widget filialData(filial, data){
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children:  <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Filial: ", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),)),
            Padding(
                padding: EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Ex. 01",
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  keyboardType: TextInputType.number,
                  controller: filial,
                )),
            const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Data Apuração", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child:  TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Ex. 01/22",
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [DateTextFormatter()],
                  keyboardType: TextInputType.number,
                  controller: data,
                )),
          ])
        ]),
  );
}
Widget header() {
  return SizedBox(
    height: 17,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: const <TableRow>[
          TableRow(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Descrição", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Valores", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Rateio", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          ])
        ]),
  );
}

Widget folhaAdm(folhaAV, folhaAR) {
  PayRollManual pay = PayRollManual();
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child:
                Text("Folha Adm + Provisões", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: folhaAV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: folhaAR,
                )),
          ])
        ]),
  );
}

Widget extraFolhaA(extFolhaAV, extFolhaAR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Extra Folha Adm", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: extFolhaAV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: extFolhaAR,
                )),
          ])
        ]),
  );
}

Widget valeTransA(vtAV, vtAR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child:
                Text("Vale Transporte Adm", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vtAV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vtAR,
                )),
          ])
        ]),
  );
}

Widget valeAlimA(vaAV, vaAR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child:
                Text("Vale Alimentação Adm", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vaAV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vaAR,
                )),
          ])
        ]),
  );
}

Widget valeAlimTransC(vatCV, vatCR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Vale Alim. e Transp. Comercial",
                    textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vatCV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: vatCR,
                )),
          ])
        ]),
  );
}

Widget folhaCom(folhaCV, folhaCR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text("Folha Comercial + Provisões",
                    textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: folhaCV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: folhaCR,
                )),
          ])
        ]),
  );
}

Widget extraFolhaC(extFolhaCV, extFolhaCR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child:
                Text("Extra Folha Comercial", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: extFolhaCV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: extFolhaCR,
                )),
          ])
        ]),
  );
}
Widget representantes(represV, represR) {
  return SizedBox(
    height: 50,
    child: Table(
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.black),
        children: <TableRow>[
          TableRow(children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(2.0),
                child:
                Text("Representantes", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: represV,
                )),
            Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  controller: represR,
                )),
          ])
        ]),
  );
}
