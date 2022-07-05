import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/anos/anos.dart';

class FaturamentoView extends StatefulWidget {
  const FaturamentoView({Key? key}) : super(key: key);

  @override
  _FaturamentoViewState createState() => _FaturamentoViewState();
}

class _FaturamentoViewState extends State<FaturamentoView> {
  var ano;
  var teste = 0;

  @override
  Widget build(BuildContext context) {
    var media = 0.00;
    var result = 0;
    var periodo = 0;


    var snapshots = FirebaseFirestore.instance
        .collection("faturamento")
        .doc(ano)
        .collection("meses")
        .orderBy("pos")
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Faturamentos"),
        ),
        body: teste == 0
            ? Container(
                height: double.infinity,
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  const Text(
                    'Selecione o Ano: ',
                    style: TextStyle(fontSize: 40),
                  ),
                  Expanded(
                      child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: List.generate(opcoes.length, (index) {
                            return Center(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ano = opcoes[index].titulo!;
                                        teste = 1;
                                      });
                                    },
                                    child: Card(
                                        color: Colors.blueAccent,
                                        child: Center(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  opcoes[index].titulo!,
                                                  style: const TextStyle(
                                                      fontSize: 30),
                                                ),
                                              ]),
                                        ))));
                          })))
                ]))
            : StreamBuilder(
                stream: snapshots,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    var item = snapshot.data!.docs[i];
                    final int valor = int.parse(item["valor"].toString());
                    result = result + valor;
                    periodo = i;
                  }
                  periodo = periodo + 1;
                  media = result / periodo;
                  if (result == 0) {
                    return const Center(
                        child: Text("Ano inválido ou sem base de Dados"));
                  }

                  return SingleChildScrollView(
                      child: Column(children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
