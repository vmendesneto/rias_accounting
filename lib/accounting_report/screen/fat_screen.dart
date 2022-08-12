import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/financial_report/%20devolution/providers/devolution_provider.dart';
import 'package:rias_accounting/financial_report/receive/providers/receive_provider.dart';
import 'package:collection/collection.dart';

import '../../financial_report/sales/provider/sale_provider.dart';

class FatScreen extends ConsumerStatefulWidget {
  final String title;

  FatScreen({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => FatScreenState();
}

class FatScreenState extends ConsumerState<FatScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
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
                width: 1200,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _height * 0.009),
                          sale(),
                          SizedBox(height: _height * 0.003),
                          rec(),
                        ])))));
  }

  Widget rec() {
    final receive = ref.watch(receiveProvider);
    return Row(children: [
      Container(
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Recebimento',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      const SizedBox(
        width: 20,
      ),
      SizedBox(
          width: 1000,
          height: 20,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: receive.count,
              itemBuilder: (context, int index) {
                double value = double.parse(receive.rest![index].toString());
                return Row(
                  children: [
                    Text(value.toStringAsFixed(2)),
                    const SizedBox(width: 20),
                  ],
                );
              })),
    ]);
  }
  Widget sale() {
    final sale = ref.watch(saleProvider);
    return Row(children: [
      Container(
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Faturamento',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      const SizedBox(
        width: 20,
      ),
      SizedBox(
          width: 1000,
          height: 20,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: sale.count,
              itemBuilder: (context, int index) {
                double value = double.parse(sale.rest![index].toString());
                return Row(
                  children: [
                    Text(value.toStringAsFixed(2)),
                    const SizedBox(width: 20),
                  ],
                );
              })),
    ]);
  }
  Widget dev() {
    final dev = ref.watch(devolutionProvider);
    return Row(children: [
      Container(
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          padding: const EdgeInsets.all(2),
          child: const Text('Devoluções',
              //                   // style: state.textTheme.bodyText1,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600))),
      const SizedBox(
        width: 20,
      ),
      SizedBox(
          width: 1000,
          height: 20,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: dev.count,
              itemBuilder: (context, int index) {
                double value = double.parse(dev.rest![index].toString());
                return Row(
                  children: [
                    Text(value.toStringAsFixed(2)),
                    const SizedBox(width: 20),
                  ],
                );
              })),
    ]);
  }
}
