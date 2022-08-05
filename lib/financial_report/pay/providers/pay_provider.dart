

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/services/pay_controller.dart';

final payProvider = StateNotifierProvider<PayController, ViewState>((ref) => PayController());