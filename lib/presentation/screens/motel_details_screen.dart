import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/models/motel_model.dart';
import '../providers/suite_provider.dart';
import '../widgets/suite_card.dart';

class MotelDetailsScreen extends ConsumerWidget {
  final MotelModel motel;

  const MotelDetailsScreen({super.key, required this.motel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Garante que o estado seja atualizado APÓS o primeiro build
    Future.microtask(() {
      ref.read(suiteProvider.notifier).setSuites(motel.suites);
    });

    final suites = ref.watch(suiteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(motel.fantasia),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
          ),
        ),
      ),
      body: suites.isEmpty
          ? const Center(child: Text('Nenhuma suíte disponível'))
          : ListView.builder(
              itemCount: suites.length,
              itemBuilder: (context, index) {
                final suite = suites[index];
                return SuiteCard(suite: suite);
              },
            ),
    );
  }
}
