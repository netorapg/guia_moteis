import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/services/motel_service.dart';
import '../../data/models/motel_model.dart';
import '../widgets/motel_card.dart';

class MotelList extends StatefulWidget {
  const MotelList({super.key});

  @override
  _MotelListState createState() => _MotelListState();
}

class _MotelListState extends State<MotelList> {
  late Future<List<MotelModel>> motels;

  @override
  void initState() {
    super.initState();
    motels = MotelService().fetchMotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia de Motéis'),
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
      body: FutureBuilder<List<MotelModel>>(
        future: motels,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum motel encontrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final motel = snapshot.data![index];
                return MotelCard(motel: motel);
              },
            );
          }
        },
      ),
    );
  }
}
