import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:rias_accounting/Settings/payroll_manual/domain/models/payroll_maunal_model.dart';
import 'package:rias_accounting/Settings/payroll_manual/widgets.dart';
import 'package:rias_accounting/database/db_firestore.dart';

import '../../core/replace_money.dart';


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
                      dataOnclick(filial, data,folhaAV, folhaAR,extFolhaAV, extFolhaAR,vtAV, vtAR,vaAV, vaAR,vatCV, vatCR,folhaCV, folhaCR,extFolhaCV,
                          extFolhaCR,represV, represR);
                    },
                    child: Text("Salvar")))
          ])),
        ));
  }
}

dataOnclick(filial, data,folhaAV, folhaAR,extFolhaAV, extFolhaAR,vtAV, vtAR,vaAV, vaAR,vatCV, vatCR,folhaCV, folhaCR,
    extFolhaCV,
    extFolhaCR,represV, represR) async {
late FirebaseFirestore db;
db = DBFirestore.get();
  PayRollManual pay = PayRollManual();
  pay.filial = int.parse(filial.text);
  pay.data = replaData(data.text);
  pay.folhaAV = num.parse(repla(folhaAV.text));
  pay.folhaAR = num.parse(repla(folhaAR.text));
  pay.extFolhaAV = num.parse(repla(extFolhaAV.text));
  pay.extFolhaAR = num.parse(repla(extFolhaAR.text));
  pay.vtAV = num.parse(repla(vtAV.text));
  pay.vtAR = num.parse(repla(vtAR.text));
  pay.vaAV = num.parse(repla(vaAV.text));
  pay.vaAR = num.parse(repla(vaAR.text));
  pay.vatCV = num.parse(repla(vatCV.text));
  pay.vatCR = num.parse(repla(vatCR.text));
  pay.folhaCV = num.parse(repla(folhaCV.text));
  pay.folhaCR = num.parse(repla(folhaCR.text));
  pay.extFolhaCV = num.parse(repla(extFolhaCV.text));
  pay.extFolhaCR = num.parse(repla(extFolhaCR.text));
  pay.represV = num.parse(repla(represV.text));
  pay.represR = num.parse(repla(represR.text));

  //SUBSTITUIR UID Pelo nome do usuario que adicionou a informação
  await db.collection('dados/uid/${pay.filial}').doc(pay.data).set({
    'folha Adm': pay.folhaAV,
    'folha Adm R': pay.folhaAR,
    'extra folha Adm': pay.extFolhaAV,
    'extra folha Adm R': pay.extFolhaAR,
    'vt Adm': pay.vtAV,
    'vt Adm R': pay.vtAR,
    'va Adm': pay.vaAV,
    'va Adm R': pay.vaAR,
    'va e vt Com': pay.vatCV,
    'va e vt Com R': pay.vatCR,
    'folha Com ': pay.folhaCV,
    'folha Com R': pay.folhaCR,
    'extra folha Com': pay.extFolhaCV,
    'extra folha Com R': pay.extFolhaCR,
    'representantes': pay.represV,
    'representantes R': pay.represR,
    'última Alteração' : DateTime.now(),
  });
}



