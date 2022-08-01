import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../provider/sale_provider.dart';

class SaleScreen extends ConsumerStatefulWidget {
  final String title;

  SaleScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => SaleScreenState();
}

class SaleScreenState extends ConsumerState<SaleScreen> {
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final sales = ref. read(saleProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                height: double.infinity,
                width: 2200,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _height * 0.009),
                          head(),
                          sales.filtered!.isEmpty ? const Text("Não há lançamentos.", style: TextStyle(fontSize: 20.0),) :
                          listData(),
                        ])))));
  }
  Widget head(){
    return Row(children: [
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Emp.',
            // style: state.textTheme.bodyText1,
            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600),)),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Data Pedido',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cliente',
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cidade',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 250,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Status',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Gerente',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cod. Div',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Rca Vend.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Livro',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Id Status',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Pedidos',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Pedido',

              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Desc.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Custo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Frete',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Outros',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('IPI',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('ICMS',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Prazo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Base',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Base Margem',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Compra',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Nº Pedido',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Prazo Média',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 170,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Prazo',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Cob.',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
      Container(
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0),
          ),
          padding:
          const EdgeInsets.only(top: 2, bottom: 2),
          child: const Text('Vlr Pes',
              // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600))),
    ]);
  }

  Widget listData() {
    final state = ref.read(saleProvider);

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
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(state.filtered![index].empresa.toString(),
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
                            (state.filtered![index].dataPedido!)))
                            .toString(),
                        //                   // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cliente.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cidadeCliente.toString(),
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
                    width: 60,
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
                    child: Text(state.filtered![index].codigoDiv.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].rcaVendedor.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
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
                    child: Text(state.filtered![index].ideStatus.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].nPedidos.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorPedido!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].desconto!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorCusto!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].frete!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].outros!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].ipi!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].icms!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorPrazo!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorBase!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorBaseMargem!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorCompra!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].nPedido.toString(),
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
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].prazo.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].cob.toString(),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
                Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    child: Text(state.filtered![index].valorPes!.toStringAsFixed(2),
                        // style: state.textTheme.bodyText1,
                        textAlign: TextAlign.center)),
              ])
            ],
          );
        });
  }
}
