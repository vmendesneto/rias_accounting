import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import 'package:rias_accounting/Settings/payroll_manual/widgets.dart';

import 'domain/service/dados_manual_repository.dart';





class PayrollManualScreen extends StatefulWidget {
  const PayrollManualScreen({Key? key}) : super(key: key);

  @override
  State<PayrollManualScreen> createState() => _PayrollManualScreenState();
}

class _PayrollManualScreenState extends State<PayrollManualScreen> {
  TextEditingController filial = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController folhaAV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController folhaAR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController folhaCV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController folhaCR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController extFolhaAV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController extFolhaAR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController extFolhaCV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController extFolhaCR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vtAV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vtAR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vaAV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vaAR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vatCV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController vatCR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController represV = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );
  TextEditingController represR = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
  );

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text("Dados Manuais",
                    style: TextStyle(fontSize: _width * 0.07)))),
        body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
              color: Colors.grey,
              // padding: const EdgeInsets.all(4),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    filialData(filial, data),
                    header(),
                    folhaAdm(folhaAV, folhaAR),
                    extraFolhaA(extFolhaAV, extFolhaAR),
                    valeTransA(vtAV, vtAR),
                    valeAlimA(vaAV, vaAR),
                    valeAlimTransC(vatCV, vatCR),
                    folhaCom(folhaCV, folhaCR),
                    extraFolhaC(extFolhaCV, extFolhaCR),
                    representantes(represV, represR),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: 250.0,
                height: 40.0,
                child: ElevatedButton(
                    onPressed: () {
                      saveAll(
                          filial,
                          data,
                          folhaAV,
                          folhaAR,
                          extFolhaAV,
                          extFolhaAR,
                          vtAV,
                          vtAR,
                          vaAV,
                          vaAR,
                          vatCV,
                          vatCR,
                          folhaCV,
                          folhaCR,
                          extFolhaCV,
                          extFolhaCR,
                          represV,
                          represR);
                    },
                    child: Text("Salvar")))
          ])),
        ));
  }
}
