import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PayRoll {
  int? empresa;
  String? funcionario;
  num? valor;
  num? projecao;
  num? total;
  int? codConta;
  String? conta;
  String? centroDeCustos;
  String? data;

  PayRoll({
    this.empresa,
    this.funcionario,
    this.valor,
    this.projecao,
    this.total,
    this.codConta,
    this.conta,
    this.centroDeCustos,
    this.data,
  });

  factory PayRoll.fromJson(Map<String, dynamic> json) {
    return PayRoll(
      empresa: json['empresa'],
      funcionario: json['funcionario'],
      valor: json['valor'],
      projecao: json['projecao'],
      total: json['total'],
      codConta: json['cod. conta'],
      conta: json['conta '],
      centroDeCustos: json['centro de custos'],
      data: json['data'],
    );
  }
}

Future<List<PayRoll>> fetchPayroll() async {
  var url =
      'https://script.google.com/macros/s/AKfycbzMW1c6RwQ7zLt3-hssVBHzqvOtCcaWMA5zWn2BDso-C9N6yTM/exec';
  final List<PayRoll> payRolls;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    //transformei em uma lista de Maps POST
    return payRolls = (json.decode(response.body) as List)
        .map((data) => PayRoll.fromJson(data))
        .toList();
  } else {
    throw Exception('Verifique Conexão e tente novamente');
  }
}
