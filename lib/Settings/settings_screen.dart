import 'package:flutter/material.dart';
import 'package:rias_accounting/Settings/payroll_manual/payroll_manual_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PayrollManualScreen()));
                },
                child: Container(
                    height: 80,
                    width: 250,
                    child: const Card(
                  color: Colors.blue,
                  child: Center(child: Text("Dados Manuais", style: TextStyle(fontSize: 20.0, color: Colors.white),)),
                ))),
          ],
        ),
      ),
    );
  }
}
