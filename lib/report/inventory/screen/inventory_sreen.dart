import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rias_accounting/report/inventory/provider/inventory_provider.dart';


class InventoryScreen extends ConsumerStatefulWidget {
  final String title;

  InventoryScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => InventoryScreenState();
}

class InventoryScreenState extends ConsumerState<InventoryScreen> {
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
                width: 1000,
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
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Id',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Produto',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Quant.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Custo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Margem (%)',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Venda',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Tipo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('NCM',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }

  Widget listData() {
    final state = ref.read(inventoryProvider);

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
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].id.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child:
                    Text(state.filtered![index].descricao.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(
                        state.filtered![index].quantidade!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child:
                    Text(state.filtered![index].custo!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].margem!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].venda!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].tipo!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].ncm!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
              ])
            ],
          );
        });
  }
}
