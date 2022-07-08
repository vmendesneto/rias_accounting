import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class PayRoll {
  int? empresa;
  String? funcionario;
  double? valor;
  double? projecao;
  double? total;
  int? codConta;
  String? conta;
  String? centroDeCustos;

  PayRoll(
      {this.empresa,
        this.funcionario,
        this.valor,
        this.projecao,
        this.total,
        this.codConta,
        this.conta,
        this.centroDeCustos});
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
    );
  }
}
Future<List<PayRoll>> fetchPost() async {
  var url =
      'https://script.googleusercontent.com/macros/echo?user_content_key=vO2ubHFiclo79mZv_kjSdQrAAglkgieP9zIdWCXMZswWygF0qsxVRsLbcomVKTohIPaZ19gMjotjmtEIjrDhWS1Zq5BEsRItm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnIdpLYZ8iKJ8kdKM3N9PZh521uEQH5gptng6fYaaN3ksZp_JPQTwcIDeuApVb8cTrEW-dnclfdIe&lib=M_DFornegD-TWVPnKwTaJuG9EiE-8kxK_';
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