
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/accounting_report/invoicing/domain/services/invoicing_controller.dart';

final invoicingProvider = StateNotifierProvider<InvoicingController, ViewState>((ref) => InvoicingController());