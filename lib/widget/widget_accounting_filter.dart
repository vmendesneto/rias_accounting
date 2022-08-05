import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/financial_report/%20devolution/providers/devolution_provider.dart';
import '../financial_report/pay/providers/pay_provider.dart';
import '../financial_report/receive/providers/receive_provider.dart';
import '../financial_report/sales/provider/sale_provider.dart';

class FilterAccounting extends ConsumerStatefulWidget {
  FilterAccounting({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => FilterAccountingState();
}

class FilterAccountingState extends ConsumerState<FilterAccounting> {
  var _itemSelecionado = 'Periodo';
  int test = 0;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final stateReceive = ref.watch(receiveProvider);
    final receive = ref.read(receiveProvider.notifier);
    final stateDev = ref.watch(devolutionProvider);
    final dev = ref.read(devolutionProvider.notifier);
    final stateSale = ref.watch(saleProvider);
    final sales = ref.read(saleProvider.notifier);

    var periodo = <List<String>, int>{
      ['Periodo']: 0,
      ['ultimo mês']: 1,
      ['ultimos 3 meses']: 2,
      ['ultimos 6 meses']: 3,
      ['ultimos 12 meses']: 4,
      ['Ano Atual']: 5,
    };
    List<String> menu = [
      'Periodo',
      'ultimo mês',
      'ultimos 3 meses',
      'ultimos 6 meses',
      'ultimos 12 meses',
      'Ano Atual'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Filtro",
          //style: TextStyle(fontSize: _width * 0.1),
        )),
      ),
      body: Column(
        children: [
          SizedBox(height: _height * 0.009),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Periodo : ",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              width: _width * 0.01,
            ),
            Container(
              color: const Color(0xffDCDCDC),
              height: _height * 0.05,
              width: _width * 0.43,
              child: DropdownButton<String>(
                alignment: Alignment.center,
                dropdownColor: Colors.white,
                items: menu.map((String? dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Center(child: Text(dropDownStringItem!)),
                  );
                }).toList(),
                autofocus: true,
                isExpanded: true,
                onChanged: (String? novoItemSelecionado) {
                  for (final entry in periodo.entries) {
                    if (entry.key.contains(novoItemSelecionado)) {
                      test = entry.value;
                      print(test);
                    }
                  }
                  _dropDownItemSelected(novoItemSelecionado!);
                  setState(() {
                    _itemSelecionado = novoItemSelecionado;
                  });
                },
                value: _itemSelecionado,
              ),
            ),
          ]),
          SizedBox(
            height: _height * 0.02,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text('Empresas', style: TextStyle(fontSize: 20.0)),
          ]),
          SizedBox(
            height: _height * 0.02,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            height: 40.0,
            child: listEmpresas(
                stateReceive, receive, stateDev, dev, stateSale, sales),
          ),
          SizedBox(
            height: _height * 0.02,
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            height: _height * 0.05,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  period(receive, dev, sales);
                },
                child: const Text(
                  "Exibir",
                  style: TextStyle(fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }

  void period(receive, dev, sales) async {
    if (test == 1) {
      var totalRec = await receive.filterAccount();
      var totalDev = await dev.filterAccount();
      var totalSales = await sales.filterAccount();
      print(totalRec);
      print(totalDev);
      print(totalSales);
    }
  }

  Widget listEmpresas(stateReceive, receive, stateDev, dev, stateSale, sales) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stateReceive.empresas.length,
        itemBuilder: (context, index) {
          return Container(
              width: 70,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  stateReceive.empresas[index].toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                Checkbox(
                    value: stateReceive.check
                            .contains(stateReceive.empresas[index])
                        ? true
                        : false,
                    onChanged: (val) {
                      if (val == true) {
                        sales.trueCheck(stateSale.empresas[index]);
                        dev.trueCheck(stateDev.empresas[index]);
                        receive.trueCheck(stateReceive.empresas[index]);
                      } else {
                        sales.trueCheck(stateSale.empresas[index]);
                        dev.trueCheck(stateDev.empresas[index]);
                        receive.falseCheck(stateReceive.empresas[index]);
                      }
                    })
              ]));
        });
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      _itemSelecionado = novoItem;
    });
  }
}
