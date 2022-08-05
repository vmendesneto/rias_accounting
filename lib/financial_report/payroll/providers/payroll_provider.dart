


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/service/payroll_controller.dart';

final payrollProvider = StateNotifierProvider<PayrollController, ViewState>((ref) => PayrollController());