import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../financial_report/ devolution/providers/devolution_provider.dart';
import '../../financial_report/pay/providers/pay_provider.dart';
import '../../financial_report/sales/provider/sale_provider.dart';


class DreScreen extends ConsumerStatefulWidget {
  final String title;

  const DreScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => DreScreenState();
}

class DreScreenState extends ConsumerState<DreScreen> {
  List<num> cmvList = [];
  List<num> despCom = [];
  List<num> fatList = [];
  double mediaHeight = 0.00;


  @override
  void initState() {
    super.initState();

    final stateSale = ref.read(saleProvider);
    fatList = stateSale.faturList!;
    cmvList = stateSale.cmvSaleList!;
    despCom = stateSale.despComSaleList!;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      meses(ref),

                      fatBruto(ref, fatList),

                      devolucoes(ref),

                      fatLiq(ref, fatList),

                      cmv(ref, cmvList),

                      margemBruta(ref, cmvList, fatList),

                      despComerc(ref, fatList, despCom),

                      freteReemb(ref),

                      freteSaida(ref),

                      proLabore(fatList),

                      margemCont(cmvList, fatList, despCom),
                  
                    ],
                  )),
            )));
  }
}

fatBruto(WidgetRef ref, fatList) {
  final stateSale = ref.watch(saleProvider);

  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              defaultVerticalAlignment:
              TableCellVerticalAlignment.middle,
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(2.0),
                      child:
                          Text("(=) Fat. Bruto", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: stateSale.count,
              itemBuilder: (context, int i) {
                double value = double.parse(stateSale.rest![i].toString());
                return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                          defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                          defaultColumnWidth: const FixedColumnWidth(100),
                          border: TableBorder.all(color: Colors.black),
                          children: <TableRow>[
                            TableRow(children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

devolucoes(WidgetRef ref) {
  final stateDev = ref.watch(devolutionProvider);
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child:
                          Text("(-) Devoluções", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: stateDev.count,
              itemBuilder: (context, int index) {
                double value = double.parse(stateDev.rest![index].toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

Widget fatLiq(WidgetRef ref, fatList) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child:
                          Text("(=) Fat. Liquido", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fatList.length,
              itemBuilder: (context, int i) {
                double value = double.parse((fatList![i]).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

cmv(WidgetRef ref, cmvList) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text('(-) Custo Mercadoria Vendida',
                          textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cmvList.length,
              itemBuilder: (context, int i) {
                double value = double.parse((cmvList[i]).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

margemBruta(WidgetRef ref, cmvList, fatList) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child:
                          Text("(=) Margem Bruta", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fatList.length,
              itemBuilder: (context, int i) {
                double value =
                    double.parse((fatList[i] - cmvList[i]).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

despComerc(WidgetRef ref, fatList, despCom) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("(-) Despesas de Comercialização",
                          textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: despCom.length,
              itemBuilder: (context, int i) {
                double value = double.parse((despCom[i]).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

freteReemb(WidgetRef ref) {
  final stateSale = ref.watch(saleProvider);
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("(+) Frete Reembolso",
                          textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: stateSale.restFrete!.length,
              itemBuilder: (context, int index) {
                double value =
                    double.parse(stateSale.restFrete![index].toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

freteSaida(WidgetRef ref) {
  final statePay = ref.watch(payProvider);
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("Frete Saída", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: statePay.rest!.length,
              itemBuilder: (context, int i) {
                double value = double.parse(statePay.rest![i].toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

proLabore(fatList) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("Pro-Labore variavél comp.",
                          textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fatList.length,
              itemBuilder: (context, int i) {
                double value = double.parse((fatList[i] * 0.01).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

margemCont(cmvList, fatList, despCom) {
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("(=) Margem de Contribuição",
                          textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fatList.length,
              itemBuilder: (context, int i) {
                var margem = fatList[i] - cmvList[i];
                double value =
                    double.parse((margem - (-despCom[i])).toString());
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: Text(value.toStringAsFixed(2),
                                      textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}

meses(WidgetRef ref) {
  final sale = ref.watch(saleProvider);
  List mesesList = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  return Container(
      height: 17,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
              defaultColumnWidth: const FixedColumnWidth(200),
              border: TableBorder.all(color: Colors.black),
              children: const <TableRow>[
                TableRow(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("", textAlign: TextAlign.center))
                ])
              ]),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: sale.meses!.length,
              itemBuilder: (context, int index) {
                int mes = int.parse(sale.meses![index]) - 1;
                if (mes == -1) {
                  mes = 11;
                } else if (mes == -2) {
                  mes = 10;
                } else if (mes == -3) {
                  mes = 9;
                } else if (mes == -4) {
                  mes = 8;
                }
                String meses = mesesList[mes];
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
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child:
                                      Text(meses, textAlign: TextAlign.center))
                            ])
                          ])
                    ]);
              })
        ],
      ));
}
