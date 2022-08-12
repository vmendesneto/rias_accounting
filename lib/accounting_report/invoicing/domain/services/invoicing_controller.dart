import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../financial_report/ devolution/domain/services/devolution_controller.dart';
import '../../../../financial_report/receive/domain/services/receive_controller.dart';
import '../../../../financial_report/sales/domain/services/sales_controller.dart';

class ViewState {
  bool allSelected;
  List? one;

  ViewState({
    this.allSelected = false,
    this.one,
  });
}

class InvoicingController extends StateNotifier<ViewState> {
  InvoicingController([ViewState? state]) : super(ViewState());

  SaleController sales = SaleController();
  DevolutionController dev = DevolutionController();
  ReceiveController receive = ReceiveController();


}
