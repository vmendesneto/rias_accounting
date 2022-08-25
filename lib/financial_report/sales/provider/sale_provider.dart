

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/services/sales_controller.dart';

final saleProvider = StateNotifierProvider<SaleController, ViewStates>((ref) => SaleController());