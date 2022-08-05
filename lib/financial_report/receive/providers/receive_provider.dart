

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/services/receive_controller.dart';

final receiveProvider = StateNotifierProvider<ReceiveController, ViewReceiveState>((ref) => ReceiveController());