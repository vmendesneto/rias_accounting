import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../financial_report/ devolution/domain/services/devolution_controller.dart';
import '../../../../financial_report/receive/domain/services/receive_controller.dart';
import '../../../../financial_report/sales/domain/services/sales_controller.dart';

class ViewState {
  bool allSelected;

  ViewState({
    this.allSelected = false,
  });
}

class InvoicingController extends StateNotifier<ViewState> {
  InvoicingController([ViewState? state]) : super(ViewState());

  SaleController sales = SaleController();
  DevolutionController dev = DevolutionController();
  ReceiveController receive = ReceiveController();

 //  invoicingAllSelected(bool select, int emp) {
 //    if (select == true) {
 //  //    sales.trueCheck(emp);
 // //     dev.trueCheck(emp);
 //      receive.trueCheck(emp);
 //    } else {
 // //     sales.falseCheck(emp);
 // //     dev.falseCheck(emp);
 //      receive.falseCheck(emp);
 //    }
 //    state = ViewState(allSelected: select);
 //    print(state.allSelected);
 //    return select;
 //  }
}
