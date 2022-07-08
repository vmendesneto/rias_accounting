import 'package:flutter/material.dart';
import '../report/receive/domain/models/receive_model.dart';
import '../report/report_screen/reportScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Rias-Accounting", style: TextStyle(fontSize: _width * 0.07))),
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
                await fetchReceive();
                // Navigator.push(
                //   context, MaterialPageRoute(
                //     builder: (context) => const ReportScreen()),);
              },
            ),
            // ListTile(
            //   selected: 2 == _selectedIndex,
            //   title: const Text('Relatórios Contabéis'),
            //   onTap: () {
            //     _onSelectItem(2);
            //
            //     // Update the state of the app
            //     // ...
            //     // Then close the drawer
            //   },
            // ),
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

    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
