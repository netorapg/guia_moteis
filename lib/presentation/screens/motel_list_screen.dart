import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/motel_provider.dart';
import '../widgets/motel_card.dart';

class MotelListScreen extends ConsumerWidget {
  const MotelListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motelList = ref.watch(motelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Motéis Disponíveis')),
      body: motelList.when(
        data: (motels) => ListView.builder(
          itemCount: motels.length,
          itemBuilder: (context, index) => MotelCard(motel: motels[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }
}
