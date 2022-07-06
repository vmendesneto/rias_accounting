import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;



class Sale {
  int? empresa;
  String? dataPedido;
  int? cliente;
  String? cidadeCliente;
  String? statusCliente;
  int? rcaGerente;
  int? codigoDiv;
  int? rcaVendedor;
  int? livro;
  String? ideStatus;
  int? nPedidos;
  double? valorPedido;
  int? desconto;
  double? valorCusto;
  int? frete;
  int? outros;
  int? ipi;
  int? icms;
  double? valorPrazo;
  double? valorBase;
  double? valorBaseMargem;
  double? valorCompra;
  int? nPedido;
  int? prazoMedia;
  String? prazo;
  String? cob;
  double? valorPes;


  Sale({this.empresa,
    this.dataPedido,
    this.cliente,
    this.cidadeCliente,
    this.statusCliente,
    this.rcaGerente,
    this.codigoDiv,
    this.rcaVendedor,
    this.livro,
    this.ideStatus,
    this.nPedidos,
    this.valorPedido,
    this.desconto,
    this.valorCusto,
    this.frete,
    this.outros,
    this.ipi,
    this.icms,
    this.valorPrazo,
    this.valorBase,
    this.valorBaseMargem,
    this.valorCompra,
    this.nPedido,
    this.prazoMedia,
    this.prazo,
    this.cob,
    this.valorPes
  });
  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      empresa : json['empresa'],
      dataPedido : json['data_pedido'],
      cliente : json['cliente'],
      cidadeCliente : json['cidade_cliente'],
      statusCliente : json['status_cliente'],
      rcaGerente : json['rca_gerente'],
      codigoDiv :json['codigo_div'],
      rcaVendedor : json['rca_vendedor'],
      livro : json['livro'],
      ideStatus : json['ide_status'],
      nPedidos : json['n_pedidos'],
      valorPedido : json['valor_pedido'],
      desconto : json['desconto'],
      valorCusto : json['valor_custo'],
      frete : json['frete'],
      outros : json['outros'],
      ipi : json['ipi'],
      icms : json['icms'],
      valorPrazo : json['valor_prazo'],
      valorBase : json['valor_base'],
      valorBaseMargem : json['valor_base_margem'],
      valorCompra : json['valor_compra'],
      nPedido : json['n_pedido'],
      prazoMedia : json['prazo media'],
      prazo : json['prazo'],
      cob : json['cob.'],
      valorPes : json['valor_pes'],
    );
  }
}
Future<List<Sale>> fetchSale() async {
  final List<Sale> sales;
  final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbxS0uh0QW5xiZ-sdoyK2sqoq8qxQdlF16gK9daxNealj290SUc/exec'));
  if (response.statusCode == 200) {

    //transformei em uma lista de Maps POST
    return sales = (json.decode(response.body) as List)
        .map((data) => Sale.fromJson(data))
        .toList();


  } else {
    throw Exception('Falha ao carregar um post');
  }
}