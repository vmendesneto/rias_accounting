import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:core';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackListPage(),
    );
  }
}

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({Key? key}) : super(key: key);

  @override
  State<FeedbackListPage> createState() => _FeedbackListPage();
}

class _FeedbackListPage extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>.empty();

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List dados = [];
    var ola = 0;
    return Scaffold(
        appBar: AppBar(
          title: Text("teste"),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(children: [
              Expanded(
                  child: SizedBox(
                    height: 30,
                    width: 100,
                    child: ElevatedButton(
                      child: const Text("Atualizar"),
                      onPressed: () {

                        for (var i = 0; i < feedbackItems.length; i++) {
                          print(feedbackItems[i].mes12);
                          var teste = feedbackItems[i].mes12 != "" && feedbackItems[i].mes12 != "-"
                              ? int.parse(feedbackItems[i].mes12)
                              : 0;
                          var result = teste == 0 ? 0 : teste + 5;
                          dados.add(result);

                        }
                        print(dados.toString());
                      },
                    ),
                  )),
            ])));
  }
}

class FeedbackForm {
  String? dados;
  String media;
  String? mes1;
  String mes2;
  String mes3;
  String mes4;
  String mes5;
  String mes6;
  String mes7;
  String mes8;
  String mes9;
  String mes10;
  String mes11;
  String mes12;

  FeedbackForm(
      this.dados,
      this.media,
      this.mes1,
      this.mes2,
      this.mes3,
      this.mes4,
      this.mes5,
      this.mes6,
      this.mes7,
      this.mes8,
      this.mes9,
      this.mes10,
      this.mes11,
      this.mes12,
      );

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['dados']}",
        "${json['media']}",
        "${json['mes1']}",
        "${json['mes2']}",
        "${json['mes3']}",
        "${json['mes4']}",
        "${json['mes5']}",
        "${json['mes6']}",
        "${json['mes7']}",
        "${json['mes8']}",
        "${json['mes9']}",
        "${json['mes10']}",
        "${json['mes11']}",
        "${json['mes12']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'dados': dados,
    'media': media,
    'mes1': mes1,
    'mes2': mes2,
    'mes3': mes3,
    'mes4': mes4,
    'mes5': mes5,
    'mes6': mes6,
    'mes7': mes7,
    'mes8': mes8,
    'mes9': mes9,
    'mes10': mes10,
    'mes11': mes11,
    'mes12': mes12
  };
}

class FormController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbyMqPR3cpCzGCuv0kLX0KBEk2O9a1ulbK7wyqrf5jW8uJjduDI/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http
          .post(Uri.parse(URL), body: feedbackForm.toJson())
          .then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<FeedbackForm>> getFeedbackList() async {
    String URL =
        "https://script.google.com/macros/s/AKfycbyMqPR3cpCzGCuv0kLX0KBEk2O9a1ulbK7wyqrf5jW8uJjduDI/exec";
    return await http.get(Uri.parse(URL)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      print(jsonFeedback);
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });
  }
}
