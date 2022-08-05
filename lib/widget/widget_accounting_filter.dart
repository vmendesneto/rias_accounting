import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/report/pay/providers/pay_provider.dart';

class FilterAccounting extends ConsumerStatefulWidget {
  FilterAccounting({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => FilterAccountingState();
}

class FilterAccountingState extends ConsumerState<FilterAccounting> {
  var _monthSelected = 'Janeiro';
  var yearSelected = '2022';

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final pay = ref.read(payProvider);
    var _month = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto ',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro'
    ];
    var year = ['2018','2019', '2020','2021','2022'];

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Filtro",
          //style: TextStyle(fontSize: _width * 0.1),
        )),
      ),
      body: Column(children: [
        SizedBox(height: _height * 0.009),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Mês : ",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              width:_width * 0.01,
            ),
            Container(
                color: const Color(0xffDCDCDC),
                height: _height * 0.05,
                width: _width * 0.3,
                child: DropdownButton<String>(
                    // dropdownColor: state.primaryColor,
                    items: _month.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Center(
                              child: Text(
                            dropDownStringItem,
                            //style:
                            // state.textTheme.headline5,
                          )));
                    }).toList(),
                    autofocus: true,
                    isExpanded: true,
                    onChanged: (String? novoItemSelecionado) {
                      _dropDownMonthSelected(novoItemSelecionado!);
                      setState(() {
                        _monthSelected = novoItemSelecionado;
                      });
                    },
                    value: _monthSelected)),
             SizedBox(
              width: _width * 0.01,
            ),
            const Text(
              "Ano : ",
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              width: 0.05,
            ),
            Container(
                color: const Color(0xffDCDCDC),
                height: _height * 0.05,
                width: _width * 0.3,
                child: DropdownButton<String>(
                  // dropdownColor: state.primaryColor,
                    items: year.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Center(
                              child: Text(
                                dropDownStringItem,
                                //style:
                                // state.textTheme.headline5,
                              )));
                    }).toList(),
                    autofocus: true,
                    isExpanded: true,
                    onChanged: (String? newyearSelected) {
                      _dropDownYearSelected(newyearSelected!);
                      setState(() {
                        yearSelected = newyearSelected;
                      });
                    },
                    value: yearSelected)),
          ],
        ),

      ]),
    );
  }

  void _dropDownMonthSelected(String newMonth) {
    setState(() {
      _monthSelected = newMonth;
    });
  }
  void _dropDownYearSelected(String newYear) {
    setState(() {
      yearSelected = newYear;
    });
  }
}
