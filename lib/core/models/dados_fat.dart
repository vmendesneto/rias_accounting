import 'package:cloud_firestore/cloud_firestore.dart';

class FatModel {
  String? mes;
  int? valor;

  FatModel({this.mes,this.valor});

  factory FatModel.fromFireStore(DocumentSnapshot doc)
  {
    final data = doc.data as Map<String, dynamic>;
    return FatModel(
        mes: data['mes'],
        valor: data['valor'],
    );
  }
}