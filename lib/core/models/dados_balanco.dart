

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
//adicionar no firebase
// FirebaseFirestore.instance
//     .collection('data')
// .add({'text': 'data added through app'});