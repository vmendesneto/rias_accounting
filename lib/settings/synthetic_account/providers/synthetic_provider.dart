import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/service/synthetic_account_controller.dart';

final sharedProvider = StateNotifierProvider<SharedController, SharedState>(
      (ref) => SharedController(),
);