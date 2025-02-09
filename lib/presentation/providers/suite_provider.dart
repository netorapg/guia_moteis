import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/suite_model.dart';

class SuiteNotifier extends StateNotifier<List<Suite>> {
  SuiteNotifier() : super([]);

  void setSuites(List<Suite> suites) {
    state = suites;
  }
}

final suiteProvider = StateNotifierProvider<SuiteNotifier, List<Suite>>(
  (ref) => SuiteNotifier(),
);
