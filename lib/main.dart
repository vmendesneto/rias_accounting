import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rias_accounting/core/models/dados_fat.dart';
import 'package:rias_accounting/view/faturamentos/faturamento.dart';

import 'dart:core';

import 'core/client/json_client.dart';
import 'core/models/dados_balanco.dart';
import 'view/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
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
    var media = 0.00;
    var result = 0;
    var snapshots = FirebaseFirestore.instance
        .collection("faturamento")
        .doc("2014")
        .collection("meses")
        .orderBy("pos")
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Faturamento"),
        ),
        body: StreamBuilder(
          stream: snapshots,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              var item = snapshot.data!.docs[i];
              final int valor = int.parse(item["valor"].toString());
              result = result + valor;
              if(i==11 ){
                media = result / 12;
              }
            }
            return SingleChildScrollView(
                child:Column(
                        children: [
                           ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            var item = snapshot.data!.docs[i];
                            return ListTile(
                              title: Text(item["mes"]),
                              subtitle: Text(item["valor"].toString()),
                            );
                          }),
                      Center(
                          child: ListTile(
                              title: const Text("Total"),
                              subtitle: Text(result.toString()))),
                          Center(
                              child: ListTile(
                                  title: const Text("Média"),
                                  subtitle: Text(media.toStringAsFixed(0)))),
                    ]));
          },
        ));
  }
}

//Container(
//     height: double.infinity,
//     width: double.infinity,
//     child: Column(children: [
//       Expanded(
//           child: SizedBox(
//             height: 30,
//             width: 100,
//             child: ElevatedButton(
//               child: const Text("Atualizar"),
//               onPressed: () {
//
//                 for (var i = 0; i < feedbackItems.length; i++) {
//                   print(feedbackItems[i].mes12);
//                   var teste = feedbackItems[i].mes12 != "" && feedbackItems[i].mes12 != "-"
//                       ? int.parse(feedbackItems[i].mes12)
//                       : 0;
//                   var result = teste == 0 ? 0 : teste + 5;
//                   dados.add(result);
//
//                 }
//                 print(dados.toString());
//               },
//             ),
//           )),
//     ])));
