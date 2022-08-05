

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/services/inventory_controller.dart';

final inventoryProvider = StateNotifierProvider<InventoryController, ViewState>((ref) => InventoryController());