import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/report/%20devolution/domain/models/devolution_model.dart';
import 'package:rias_accounting/report/%20devolution/providers/devolution_provider.dart';
import 'package:rias_accounting/report/inventory/domain/models/inventory_model.dart';
import 'package:rias_accounting/report/inventory/provider/inventory_provider.dart';
import 'package:rias_accounting/report/payroll/domain/models/payroll_model.dart';
import 'package:rias_accounting/report/payroll/providers/payroll_provider.dart';
import 'package:rias_accounting/report/sales/provider/sale_provider.dart';
import '../report/pay/domain/models/pay_model.dart';
import '../report/pay/providers/pay_provider.dart';
import '../report/receive/domain/models/receive_model.dart';
import '../report/receive/providers/receive_provider.dart';
import '../report/report_screen/reportScreen.dart';
import '../report/sales/domain/models/sales_model.dart';
import '../widget/wigted_calender.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  Future<List<Receive>>? receives;
  Future<List<Pay>>? pays;
  Future<List<Devolution>>? devs;
  Future<List<PayRoll>>? payrolls;
  Future<List<Inventory>>? inventorys;
  Future<List<Sale>>? sales;

  @override
  Widget build(BuildContext context) {
    final receive = ref.read(receiveProvider.notifier);
    final pay = ref.read(payProvider.notifier);
    final dev = ref.read(devolutionProvider.notifier);
    final payroll = ref.read(payrollProvider.notifier);
    final inventory = ref.read(inventoryProvider.notifier);
    final sale = ref.read(saleProvider.notifier);
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Rias-Accounting",
                style: TextStyle(fontSize: _width * 0.07))),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              selected: 1 == _selectedIndex,
              title: const Text('Relatórios'),
              leading: const Icon(Icons.arrow_forward),
              onTap: () async {
                _onSelectItem(1);
                receive.dateInitial();
                pay.dateInitial();
                dev.dateInitial();
                payroll.dateInitial();
                devs = dev.emp();
                receives = receive.emp();
                pays = pay.emp();
                payrolls = payroll.emp();
                sale.dateInitial();
                sales = sale.emp();
              },
            ),
            ListTile(
              selected: 2 == _selectedIndex,
              title: const Text('Estoque'),
              onTap: () async {
                inventory.dateInitial();
                inventorys = inventory.emp();
                _onSelectItem(2);
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_selectedIndex),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return Container();
      case 1:
        return const ReportScreen();
      case 2 :
        return MyCalender(title: "Estoque", select: 4,);
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
