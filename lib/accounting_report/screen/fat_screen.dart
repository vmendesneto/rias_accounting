import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/financial_report/%20devolution/providers/devolution_provider.dart';
import 'package:rias_accounting/financial_report/receive/providers/receive_provider.dart';


import '../../financial_report/sales/provider/sale_provider.dart';

class FatScreen extends ConsumerStatefulWidget {
  final String title;

  FatScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => FatScreenState();
}

class FatScreenState extends ConsumerState<FatScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: double.infinity,
              width: 1310,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      meses(),
                      const SizedBox(height: 1.2),
                      sale(),
                      const SizedBox(height: 1.2),
                      dev(),
                      const SizedBox(height: 1.2),
                      frete(),
                      const SizedBox(height: 1.2),
                      fatLiq(),
                      const SizedBox(height: 1.2),
                      cmv(),
                      const SizedBox(height: 1.2),
                      rec(),
                    ],
                  )),
            )));
  }

  rec() {
    final receive = ref.watch(receiveProvider);
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text("Recebido", textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: receive.count,
                itemBuilder: (context, int index) {
                  double value = double.parse(receive.rest![index].toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  sale() {
    final sale = ref.watch(saleProvider);
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text("Vendas", textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: sale.count,
                itemBuilder: (context, int index) {
                  double value = double.parse(sale.rest![index].toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  frete() {
    final sale = ref.watch(saleProvider);
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text("Frete", textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: sale.count,
                itemBuilder: (context, int index) {
                  double value =
                      double.parse(sale.restFrete![index].toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  fatLiq() {
    final sale = ref.watch(saleProvider);
    final dev = ref.watch(devolutionProvider);

    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child:
                            Text('Fat. Liquido', textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: sale.count,
                itemBuilder: (context, int index) {
                  double value = double.parse(
                      (sale.rest![index] - dev.rest![index]).toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  dev() {
    final dev = ref.watch(devolutionProvider);
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text('Devoluções', textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: dev.count,
                itemBuilder: (context, int index) {
                  double value = double.parse(dev.rest![index].toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  cmv() {
    final sale = ref.watch(saleProvider);
    final dev = ref.watch(devolutionProvider);
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text('CMV Liq.', textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: dev.count,
                itemBuilder: (context, int index) {
                  double value = double.parse(
                      (sale.restCusto![index] - dev.restCusto![index])
                          .toString());
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(value.toStringAsFixed(2),
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }

  meses() {
    final sale = ref.watch(saleProvider);
    List mesesList = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
    return Container(
        height: 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.all(color: Colors.black),
                children: const <TableRow>[
                  TableRow(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text('Mês', textAlign: TextAlign.center))
                  ])
                ]),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: sale.meses!.length,
                itemBuilder: (context, int index) {
                  int mes = int.parse(sale.meses![index])-1;
                  if(mes == -1){
                    mes = 11;
                  }else if(mes == -2){
                    mes = 10;
                  }else if(mes == -3){
                    mes = 9;
                  }else if(mes == -4){
                    mes = 8;
                  }
                  String meses = mesesList[mes];
                  print(meses);
                  return Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                            defaultColumnWidth: const FixedColumnWidth(100),
                            border: TableBorder.all(color: Colors.black),
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2, bottom: 2),
                                    child: Text(meses,
                                        textAlign: TextAlign.center))
                              ])
                            ])
                      ]);
                })
          ],
        ));
  }
}
