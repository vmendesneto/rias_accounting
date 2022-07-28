import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Devolution {
  int? cliente;
  String? cidadeCliente;
  String? statusCliente;
  int? rcaVendedor;
  int? rcaGerente;
  int? codigoDiv;
  int? empresa;
  String? dataLancamento;
  int? livro;
  double? valor;
  double? valorBase;
  double? valorCusto;
  int? prazoMedia;
  String? prazo;
  String? cob;
  int? nContasReceber;

  Devolution(
      {this.cliente,
      this.cidadeCliente,
      this.statusCliente,
      this.rcaVendedor,
      this.rcaGerente,
      this.codigoDiv,
      this.empresa,
      this.dataLancamento,
      this.livro,
      this.valor,
      this.valorBase,
      this.valorCusto,
      this.prazoMedia,
      this.prazo,
      this.cob,
      this.nContasReceber});

  factory Devolution.fromJson(Map<String, dynamic> json) {
    return Devolution(
      cliente: json['cliente'],
      cidadeCliente: json['cidade_cliente'],
      statusCliente: json['status_cliente'],
      rcaVendedor: json['rca_vendedor'],
      rcaGerente: json['rca_gerente'],
      codigoDiv: json['codigo_div'],
      empresa: json['empresa'],
      dataLancamento: json['data_lancamento'],
      livro: json['livro'],
      valor: json['valor'],
      valorBase: json['valor_base'],
      valorCusto: json['valor_custo'],
      prazoMedia: json['prazo_media'],
      prazo: json['prazo'],
      cob: json['cob.'],
      nContasReceber: json['n_contas_receber'],
    );
  }
}

Future<List<Devolution>> fetchDevolution() async {
  final List<Devolution> devolutions;
  final response = await http.get(Uri.parse(
      'https://script.google.com/macros/s/AKfycbyJyBDRayDgUuVHXpqvoV9o68B9QxxcMYM-oZZJMj-gm_HvohY/exec'));
  if (response.statusCode == 200) {
    print(response.body);
    //transformei em uma lista de Maps POST
    return devolutions = (json.decode(response.body) as List)
        .map((data) => Devolution.fromJson(data))
        .toList();
  } else {
    throw Exception('Verifique Conexão e tente novamente');
  }
}
