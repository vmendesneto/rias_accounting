import 'package:cloud_firestore/cloud_firestore.dart';

import '../Settings/payroll_manual/domain/models/payroll_maunal_model.dart';
import '../core/replace_money.dart';
import 'db_firestore.dart';

saveAll(filial, data,folhaAV, folhaAR,extFolhaAV, extFolhaAR,vtAV, vtAR,vaAV, vaAR,vatCV, vatCR,folhaCV, folhaCR,
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