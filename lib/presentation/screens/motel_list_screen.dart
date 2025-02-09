import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../data/services/motel_service.dart';
import '../../data/models/motel_model.dart';
import '../widgets/motel_card.dart';

// Provider responsável por buscar a lista de motéis
final motelListProvider = FutureProvider<List<MotelModel>>((ref) async {
  return await MotelService().fetchMotels();
});

class MotelList extends ConsumerWidget {
  const MotelList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final motelList = ref.watch(motelListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: motelList.when(
        data: (motels) {
          if (motels.isEmpty) {
            return const Center(child: Text('Nenhum motel encontrado.'));
          }
          return ListView.builder(
            itemCount: motels.length,
            itemBuilder: (context, index) {
              return MotelCard(motel: motels[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Erro: $error')),
      ),
    );
  }
}
