import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


import '../models/dados_balanco.dart';

const String URL =
    "https://script.google.com/macros/s/AKfycbyMqPR3cpCzGCuv0kLX0KBEk2O9a1ulbK7wyqrf5jW8uJjduDI/exec";

class FormController {
  // Google App Script Web URL.

  static const STATUS_SUCCESS = "SUCCESS";

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
    return await http.get(Uri.parse(URL)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      print(jsonFeedback);
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });
  }
}