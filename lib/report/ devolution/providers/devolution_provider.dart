

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/services/devolution_controller.dart';

final devolutionProvider = StateNotifierProvider<DevolutionController, ViewState>((ref) => DevolutionController());