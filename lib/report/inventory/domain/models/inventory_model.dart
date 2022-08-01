import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Inventory {
  int? empresa;
  String? data;
  int? id;
  String? descricao;
  num? quantidade;
  num? custo;
  num? margem;
  num? venda;
  String? tipo;
  int? ncm;

  Inventory(
      {this.empresa,
      this.data,
      this.id,
      this.descricao,
      this.quantidade,
      this.custo,
      this.margem,
      this.venda,
      this.tipo,
      this.ncm});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      empresa: json['empresa'],
      data: json['data'],
      id: json['id'],
      descricao: json['descricao'],
      quantidade: json['quantidade'],
      custo: json['custo'],
      margem: json['margem'],
      venda: json['venda'],
      tipo: json['tipo'],
      ncm: json['ncm'],
    );
  }
}

Future<List<Inventory>> fetchInventory() async {
  var url =
      'https://script.google.com/macros/s/AKfycbyPhOHuwkl0lhjCWB-ch8PpNlfyaP1vPE0E3Jw8UKjXcKwf12Y/exec';
  final List<Inventory> inventorys;
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    //transformei em uma lista de Maps POST
    return inventorys = (json.decode(response.body) as List)
        .map((data) => Inventory.fromJson(data))
        .toList();
  } else {
    throw Exception('Verifique Conexão e tente novamente');
  }
}
