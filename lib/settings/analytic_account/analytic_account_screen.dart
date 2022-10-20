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

class _AnalyticAccountScreenState
    extends ConsumerState<AnalyticAccountScreen> {

  TextEditingController name = TextEditingController();

  @override
  void initState() {
    final data = ref.read(analyticProvider.notifier);
    data.readAllAnalytic("Conta q será vinculada");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final data = ref.watch(analyticProvider.notifier);
    final dataState = ref.read(analyticProvider);

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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            controller: name,
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await data.saveAllAnalytic(name.text, "Conta q será vinculada");
                        name.text = '';
                        FocusScope.of(context).requestFocus(FocusNode());
                        await data.readAllAnalytic('Conta q será vinculada');
                        setState(() {
                          dataState.listAddress;
                        });
                      },
                      child: const Text("Salvar",
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w700))),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text("Contas Cadastradas :",
                      style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700)),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataState.listAddress.length,
                          itemBuilder: (context, index) {
                            return dataState.listAddress.isNotEmpty
                                ? Text(dataState.listAddress[index].toString())
                                : Container();
                          }))
                ],
              ),
            )));
  }
}
