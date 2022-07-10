import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/report/receive/providers/receive_provider.dart';
import 'package:intl/intl.dart';

class ReceiveScreen extends ConsumerStatefulWidget {
  ReceiveScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => ReceiveScreenState();
}

class ReceiveScreenState extends ConsumerState<ReceiveScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Widget Table"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                height: double.infinity,
                width: 1900,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          head(),
                          listData(),
                        ])))));
  }
  Widget head(){
    return Row(children: [
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('NF',
            // style: state.textTheme.bodyText1,
            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),)),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Data da Nota',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Emp.',
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Serie',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Lanc.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 450,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cliente',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Valor',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Juros',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Desc.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Outros',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Total',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Pago',

              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Dt Venc.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Dt Pagamento',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cob.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Data Baixa',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Banco Baixa',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Especie',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 140,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cnpj',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 140,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Nº. bancario',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Data Acerto',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }

  Widget listData() {
    final state = ref.watch(receiveProvider);

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: state.receives!.length,
        itemBuilder: (context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(state.receives![index].nf.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                (state.receives![index].data_nota!)))
                            .toString(),
                        //                   // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].empresa!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].serie!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].lanc.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 450,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].cliente!,
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].valor.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].juros.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].desc.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].outros.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].total!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].valor_pago.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                (state.receives![index].data_vencimento!)))
                            .toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                (state.receives![index].data_pagamento!)))
                            .toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].cob.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                (state.receives![index].data_baixa!)))
                            .toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].banco_baixa.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].especie.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].cnpj.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.receives![index].n_bancario.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                state.receives![index].data_acerto!))
                            .toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
              ])
            ],
          );
        });
  }
}
