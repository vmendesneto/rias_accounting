import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Pay {
  final int? lancamento;
  final int? empresa;
  final String? data_lancamento;
  final String? vencimento;
  final String? historico;
  final String? fornecedor;
  final String? cnpj;
  final num? valor;
  final num? juros;
  final num? desc;
  final num? total;
  final String? datapagamento;
  final int? codConta;
  final String? conta;
  final String? centroCusto;
  final int? nf;

  Pay({this.lancamento, this.empresa, this.data_lancamento, this.vencimento,
    this.historico, this.fornecedor, this.cnpj, this.valor, this.juros, this.desc,
    this.total, this.datapagamento, this.codConta, this.conta,this.centroCusto, this.nf,
  });
  factory Pay.fromJson(Map<String, dynamic> json) {
    return Pay(
      lancamento: json['lancamento'],
      empresa: json['empresa'],
      data_lancamento: json['data lancamento'],
      vencimento: json['vencimento'],
      historico: json['historico'],
      fornecedor: json['fornecedor'],
      cnpj: json['cnpj'],
      valor: json['valor'],
      juros: json['juros'],
      desc: json['desc'],
      total: json['total'],
      datapagamento: json['datapamento'],
      codConta: json['cod. conta'],
      conta: json['conta'],
      centroCusto: json['centro de custos'],
      nf: json['nf'] ?? 0,
    );
  }
}

Future<List<Pay>> fetchPay() async {
  final List<Pay?> pays;
  final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbyMqPR3cpCzGCuv0kLX0KBEk2O9a1ulbK7wyqrf5jW8uJjduDI/exec'));

  if (response.statusCode == 200) {
    //transformei em uma lista de Maps POST
    return pays = (json.decode(response.body) as List)
        .map((data) => Pay.fromJson(data))
        .toList();

  } else {
    throw Exception('Verifique Conexão e tente novamente');
  }
}