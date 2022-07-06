import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Receive {
  final int? nf;
  final int? empresa;
  final int? serie;
  final int? lanc;
  final String? data_nota;
  final String? cliente;
  final String? cnpj;
  final double? valor;
  final num? juros;
  final num? desc;
  final num? outros;
  final num? total;
  final num? valor_pago;
  final String? data_vencimento;
  final String? data_pagamento;
  final String? cob;
  final String? data_baixa;
  final String? banco_baixa;
  final String? especie;
  final String? n_bancario;
  final String? data_acerto;

  Receive(
      {this.data_nota,
      this.nf,
      this.empresa,
      this.serie,
      this.lanc,
      this.cliente,
      this.valor,
      this.juros,
      this.desc,
      this.outros,
      this.total,
      this.valor_pago,
      this.data_vencimento,
      this.data_pagamento,
      this.cob,
      this.data_baixa,
      this.banco_baixa,
      this.especie,
      this.cnpj,
      this.n_bancario,
      this.data_acerto});

  factory Receive.fromJson(Map<String, dynamic> json) {
    return Receive(
      nf: json['Nº NF'],
      data_nota: json['Dt.Nota'],
      empresa: json['Emp.'],
      serie: json['Série'],
      lanc: json['Lanc.'],
      cliente: json['Cliente'],
      data_pagamento: json['Dt.Pagto'],
      data_vencimento: json['Dt.Vencimento'],
      cob: json['Cob.'],
      data_baixa: json['Dt.Baixa'],
      cnpj: json['CNPJ / CPF'],
      valor: json['Valor'],
      juros: json['Juros'],
      desc: json['Desconto'],
      outros: json['Outros'],
      total: json['Total'],
      valor_pago: json['Valor Pago'],
      banco_baixa: json['Baixado em'],
      especie: json['Espécie'],
      n_bancario: json['N.Nº Bancário'],
      data_acerto: json['Dt.Acerto'],
    );
  }
}

Future<List<Receive>> fetchReceive() async {
  final List<Receive> receives;
  final response = await http.get(Uri.parse(
      'https://script.google.com/macros/s/AKfycbyZdYaiIckDdf-YgpDDKgAj0v9LHiyfmzeoyVXA3Cfd_9uvW2sq/exec'));
  if (response.statusCode == 200) {
    //transformei em uma lista de Maps POST
    return receives = (json.decode(response.body) as List)
        .map((data) => Receive.fromJson(data))
        .toList();
  } else {
    throw Exception('Falha ao carregar um post');
  }
}
