import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rias_accounting/report/%20devolution/providers/devolution_provider.dart';

class DevScreen extends ConsumerStatefulWidget {
  final String title;

  DevScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => DevScreenState();
}

class DevScreenState extends ConsumerState<DevScreen> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  @override
  Widget build(
    BuildContext context,
  ) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                height: double.infinity,
                width: 1800,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _height * 0.009),
                          head(),
                          listData(),
                        ])))));
  }

  Widget head() {
    return Row(children: [
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text(
            'Lanc.',
            // style: state.textTheme.bodyText1,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Data da Lanc.',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Emp.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Valor',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Base',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Custo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cliente',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Status',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cidade',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cob.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Prazo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Prazo Media',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Rca Vend.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Rca Gerente',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Livro',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cod. Div',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }

  Widget listData() {
    final state = ref.read(devolutionProvider);

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: state.filtered!.length,
        itemBuilder: (context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child:
                        Text(state.filtered![index].nContasReceber.toString(),
                            // style: state.textTheme.bodyText1,
                            textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                        DateFormat("dd/MM/yyyy")
                            .format(DateTime.parse(
                                (state.filtered![index].dataLancamento!)))
                            .toString(),
                        //                   // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].empresa!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valor.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorBase.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorCusto.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cliente!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].statusCliente.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cidadeCliente!,
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cob.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].prazo!.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].prazoMedia.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(state.filtered![index].rcaVendedor.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].rcaGerente.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].livro.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].codigoDiv.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
              ])
            ],
          );
        });
  }
}
