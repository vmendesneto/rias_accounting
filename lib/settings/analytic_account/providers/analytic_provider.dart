import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rias_accounting/settings/analytic_account/domain/service/analytic_account_controller.dart';

final analyticProvider =
    StateNotifierProvider<AnalyticController, AnalyticState>(
  (ref) => AnalyticController(),
);
