import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:rias_accounting/settings/synthetic_account/domain/model/synthetic_account_model.dart';
import 'package:rias_accounting/settings/synthetic_account/providers/synthetic_provider.dart';

class SyntheticAccountScreen extends ConsumerStatefulWidget {
  const SyntheticAccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SyntheticAccountScreen> createState() =>
      _SyntheticAccountScreenState();
}

class _SyntheticAccountScreenState
    extends ConsumerState<SyntheticAccountScreen> {
  Synthetic synthetic = Synthetic();

  TextEditingController name = TextEditingController();

  @override
  void initState() {
    final data = ref.read(sharedProvider.notifier);
    data.readAllSynthetic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final data = ref.watch(sharedProvider.notifier);
    final dataState = ref.read(sharedProvider);

    return Scaffold(
        appBar: AppBar(
            title: Center(
                child: Text("Contas Sintéticas",
                    style: TextStyle(fontSize: _width * 0.07)))),
        body: Center(
            child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nome da conta sintetica : ",
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
                          LengthLimitingTextInputFormatter(28),
                        ],
                        controller: name,
                      ))),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    synthetic.name = name.text.toLowerCase();
                    await data.saveAllSynthetic(name.text);
                    name.text = '';
                    FocusScope.of(context).requestFocus(FocusNode());
                    await data.readAllSynthetic();
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
                            : const Text("Sem contas Cadastradas");
                      }))
            ],
          ),
        )));
  }
}
