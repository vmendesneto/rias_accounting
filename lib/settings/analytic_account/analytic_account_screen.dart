import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'providers/analytic_provider.dart';

class AnalyticAccountScreen extends ConsumerStatefulWidget {
  const AnalyticAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AnalyticAccountScreen> createState() =>
      _AnalyticAccountScreenState();
}

class _AnalyticAccountScreenState extends ConsumerState<AnalyticAccountScreen> {
  TextEditingController name = TextEditingController();
  String selecionado = '';

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final data = ref.watch(analyticProvider.notifier);


    final _sint = FirebaseFirestore.instance.collection('sinteticas').get();
    final _sintO = FirebaseFirestore.instance.collection('sinteticasobrigatorias').get();
    List sintetic = [];
    sintetic.add(_sint);
    sintetic.add(_sintO);

    return Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text("Contas Analíticas",
                    style: TextStyle(fontSize: _width * 0.07)))),
        body: Center(
            child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Codigo da conta analítica : ",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      height: 50.0,
                      width: 200,
                      color: Colors.grey,
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                        autocorrect: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.black,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                        ],
                        controller: name,
                      ))),
              const SizedBox(
                height: 10,
              ),
              const Text('Agrupar a conta Sintetica abaixo'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 6),
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 200,
                    color: Colors.grey,
                    child: Text(
                      selecionado,
                      style: const TextStyle(fontSize: 24),
                    ),
                  )),
              FutureBuilder(
                  future: _sint,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text(
                        'Favor cadastrar conta sintética',
                      );
                    } else {
                      return Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                return snapshot.data!.docs.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selecionado = snapshot.data!.docs[i]
                                                .get('name');
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 150,
                                            child: Text(
                                                snapshot.data!.docs[i]
                                                    .get('name')
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 24))),
                                      )
                                    : Container(
                                        child: const Text(
                                            'Favor cadastrar conta sintética'),
                                        alignment: Alignment.center,
                                      );
                              }));
                    }
                  }),
              FutureBuilder(
                  future: _sintO,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text(
                        'Favor cadastrar conta sintética',
                      );
                    } else {
                      return Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, i) {
                                return snapshot.data!.docs.isNotEmpty
                                    ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selecionado = snapshot.data!.docs[i]
                                          .get('name');
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 150,
                                      child: Text(
                                          snapshot.data!.docs[i]
                                              .get('name')
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 24))),
                                )
                                    : Container(
                                  child: const Text(
                                      'Favor cadastrar conta sintética'),
                                  alignment: Alignment.center,
                                );
                              }));
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await data.saveAllAnalytic(name.text, selecionado);
                    name.text = '';
                    FocusScope.of(context).requestFocus(FocusNode());
                    await data.readByCodAnalytic(selecionado);
                    setState(() {
                      selecionado = '';
                    });
                  },
                  child: const Text("Vincular",
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w700))),
            ],
          ),
        )));
  }
}
