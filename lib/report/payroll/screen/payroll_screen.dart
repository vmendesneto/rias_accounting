import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rias_accounting/report/payroll/providers/payroll_provider.dart';

class PayRollScreen extends ConsumerStatefulWidget {
  final String title;

  PayRollScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => PayRollScreenState();
}

class PayRollScreenState extends ConsumerState<PayRollScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                height: double.infinity,
                width: 1300,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _height * 0.009),
                          head(),
                          listData(),
                        ])))));
  }

  Widget head() {
    return Row(children: [
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Data',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Emp.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Funcionário',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Valor',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Projeção',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Total',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cod. Conta',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Conta',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Centro de Custo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }

  Widget listData() {
    final state = ref.read(payrollProvider);

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: state.filtered!.length,
        itemBuilder: (context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(
                                DateTime.parse((state.filtered![index].data!)))
                            .toString(),
                        //                   // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].empresa!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].funcionario.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child:
                        Text(state.filtered![index].valor!.toStringAsFixed(2),
                            // style: state.textTheme.bodyText1,
                            textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        state.filtered![index].projecao!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child:
                        Text(state.filtered![index].total!.toStringAsFixed(2),
                            // style: state.textTheme.bodyText1,
                            textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].codConta.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].conta.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].centroDeCustos!,
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
              ])
            ],
          );
        });
  }
}
